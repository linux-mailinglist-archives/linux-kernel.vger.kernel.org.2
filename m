Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11B5C33FF20
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 06:55:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhCRFzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 01:55:10 -0400
Received: from mail-lf1-f45.google.com ([209.85.167.45]:39587 "EHLO
        mail-lf1-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbhCRFyt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 01:54:49 -0400
Received: by mail-lf1-f45.google.com with SMTP id x28so2651123lfu.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Mar 2021 22:54:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PJOazYyNDXkrhFwfKjddL4aDj4uU5zyqKW86jj4Ji5A=;
        b=S9iTc5YOSHk7pbFMrKsIHrPIx0pu1gsdmpdpmGMzmCLBPfB/moh88FgzqPXrT1nxpr
         4/aMHpkNio7JSCCHHK7nTrtVaYq6XW9Yugu/305hXanW/mazjd32Xs5kqiJrunZuLUaz
         9+zHOCeJTiSFVwpyG3K8R+S4hHKwHRV4gK5Ybd0cjjWv+8MF7W1DHZ9zp2TmZObMfEnW
         sSWXvaLkBvjpJCB4V0KoHhXnQaWN+cCF5pFW7X4Sqnj8iBVbsdroo1H9yr+D/qYiUcP9
         Wb0RFvc5cptMR/VD3Gi67NHirxvM8OOne0biQNES7zUaHxDSGkB7/MPzzhIQHtAL/pPE
         MEjg==
X-Gm-Message-State: AOAM533zcHkhVUkd+DpNGobee0OwaaSaJrurB59UNtdgUYPjDPC5JuOV
        3vzxQZ6X9ATSnmI33zeTd38aF5bE1KeBL9+W+Wc=
X-Google-Smtp-Source: ABdhPJws/FmzqooxriUngEY19/aUA0Mq0JvAUQgxbVMIWAKDdHnJHpBNTuIrIc6wT/zGxTczCZx8TDFrRsje0gUTzSQ=
X-Received: by 2002:ac2:51b4:: with SMTP id f20mr1100560lfk.509.1616046887917;
 Wed, 17 Mar 2021 22:54:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210316211837.910506-1-songliubraving@fb.com> <20210316211837.910506-2-songliubraving@fb.com>
In-Reply-To: <20210316211837.910506-2-songliubraving@fb.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 18 Mar 2021 14:54:36 +0900
Message-ID: <CAM9d7cgqqj5_Koe_dxBxsEXqLFS6d8VOoSwkiVaEO79V55JcxQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] perf-stat: introduce bperf, share hardware PMCs
 with BPF
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 17, 2021 at 6:18 AM Song Liu <songliubraving@fb.com> wrote:
> +static int bperf_check_target(struct evsel *evsel,
> +                             struct target *target,
> +                             enum bperf_filter_type *filter_type,
> +                             __u32 *filter_entry_cnt)
> +{
> +       if (evsel->leader->core.nr_members > 1) {
> +               pr_err("bpf managed perf events do not yet support groups.\n");
> +               return -1;
> +       }
> +
> +       /* determine filter type based on target */
> +       if (target->system_wide) {
> +               *filter_type = BPERF_FILTER_GLOBAL;
> +               *filter_entry_cnt = 1;
> +       } else if (target->cpu_list) {
> +               *filter_type = BPERF_FILTER_CPU;
> +               *filter_entry_cnt = perf_cpu_map__nr(evsel__cpus(evsel));
> +       } else if (target->tid) {
> +               *filter_type = BPERF_FILTER_PID;
> +               *filter_entry_cnt = perf_thread_map__nr(evsel->core.threads);
> +       } else if (target->pid || evsel->evlist->workload.pid != -1) {
> +               *filter_type = BPERF_FILTER_TGID;
> +               *filter_entry_cnt = perf_thread_map__nr(evsel->core.threads);
> +       } else {
> +               pr_err("bpf managed perf events do not yet support these targets.\n");
> +               return -1;
> +       }
> +
> +       return 0;
> +}
> +
> +static struct perf_cpu_map *all_cpu_map;
> +
> +static int bperf_reload_leader_program(struct evsel *evsel, int attr_map_fd,
> +                                      struct perf_event_attr_map_entry *entry)
> +{
> +       struct bperf_leader_bpf *skel = bperf_leader_bpf__open();
> +       int link_fd, diff_map_fd, err;
> +       struct bpf_link *link = NULL;
> +
> +       if (!skel) {
> +               pr_err("Failed to open leader skeleton\n");
> +               return -1;
> +       }
> +
> +       bpf_map__resize(skel->maps.events, libbpf_num_possible_cpus());
> +       err = bperf_leader_bpf__load(skel);
> +       if (err) {
> +               pr_err("Failed to load leader skeleton\n");
> +               goto out;
> +       }
> +
> +       err = -1;
> +       link = bpf_program__attach(skel->progs.on_switch);
> +       if (!link) {
> +               pr_err("Failed to attach leader program\n");
> +               goto out;
> +       }
> +
> +       link_fd = bpf_link__fd(link);
> +       diff_map_fd = bpf_map__fd(skel->maps.diff_readings);
> +       entry->link_id = bpf_link_get_id(link_fd);
> +       entry->diff_map_id = bpf_map_get_id(diff_map_fd);
> +       err = bpf_map_update_elem(attr_map_fd, &evsel->core.attr, entry, BPF_ANY);
> +       assert(err == 0);
> +
> +       evsel->bperf_leader_link_fd = bpf_link_get_fd_by_id(entry->link_id);
> +       assert(evsel->bperf_leader_link_fd >= 0);

Isn't it the same as link_fd?

> +
> +       /*
> +        * save leader_skel for install_pe, which is called within
> +        * following evsel__open_per_cpu call
> +        */
> +       evsel->leader_skel = skel;
> +       evsel__open_per_cpu(evsel, all_cpu_map, -1);
> +
> +out:
> +       bperf_leader_bpf__destroy(skel);
> +       bpf_link__destroy(link);

Why do we destroy it?  Is it because we get an another reference?

> +       return err;
> +}
> +
> +static int bperf__load(struct evsel *evsel, struct target *target)
> +{
> +       struct perf_event_attr_map_entry entry = {0xffffffff, 0xffffffff};
> +       int attr_map_fd, diff_map_fd = -1, err;
> +       enum bperf_filter_type filter_type;
> +       __u32 filter_entry_cnt, i;
> +
> +       if (bperf_check_target(evsel, target, &filter_type, &filter_entry_cnt))
> +               return -1;
> +
> +       if (!all_cpu_map) {
> +               all_cpu_map = perf_cpu_map__new(NULL);
> +               if (!all_cpu_map)
> +                       return -1;
> +       }
> +
> +       evsel->bperf_leader_prog_fd = -1;
> +       evsel->bperf_leader_link_fd = -1;
> +
> +       /*
> +        * Step 1: hold a fd on the leader program and the bpf_link, if
> +        * the program is not already gone, reload the program.
> +        * Use flock() to ensure exclusive access to the perf_event_attr
> +        * map.
> +        */
> +       attr_map_fd = bperf_lock_attr_map(target);
> +       if (attr_map_fd < 0) {
> +               pr_err("Failed to lock perf_event_attr map\n");
> +               return -1;
> +       }
> +
> +       err = bpf_map_lookup_elem(attr_map_fd, &evsel->core.attr, &entry);
> +       if (err) {
> +               err = bpf_map_update_elem(attr_map_fd, &evsel->core.attr, &entry, BPF_ANY);
> +               if (err)
> +                       goto out;
> +       }
> +
> +       evsel->bperf_leader_link_fd = bpf_link_get_fd_by_id(entry.link_id);
> +       if (evsel->bperf_leader_link_fd < 0 &&
> +           bperf_reload_leader_program(evsel, attr_map_fd, &entry))
> +               goto out;
> +
> +       /*
> +        * The bpf_link holds reference to the leader program, and the
> +        * leader program holds reference to the maps. Therefore, if
> +        * link_id is valid, diff_map_id should also be valid.
> +        */
> +       evsel->bperf_leader_prog_fd = bpf_prog_get_fd_by_id(
> +               bpf_link_get_prog_id(evsel->bperf_leader_link_fd));
> +       assert(evsel->bperf_leader_prog_fd >= 0);
> +
> +       diff_map_fd = bpf_map_get_fd_by_id(entry.diff_map_id);
> +       assert(diff_map_fd >= 0);
> +
> +       /*
> +        * bperf uses BPF_PROG_TEST_RUN to get accurate reading. Check
> +        * whether the kernel support it
> +        */
> +       err = bperf_trigger_reading(evsel->bperf_leader_prog_fd, 0);
> +       if (err) {
> +               pr_err("The kernel does not support test_run for raw_tp BPF programs.\n"
> +                      "Therefore, --use-bpf might show inaccurate readings\n");
> +               goto out;
> +       }
> +
> +       /* Step 2: load the follower skeleton */
> +       evsel->follower_skel = bperf_follower_bpf__open();
> +       if (!evsel->follower_skel) {
> +               pr_err("Failed to open follower skeleton\n");
> +               goto out;
> +       }
> +
> +       /* attach fexit program to the leader program */
> +       bpf_program__set_attach_target(evsel->follower_skel->progs.fexit_XXX,
> +                                      evsel->bperf_leader_prog_fd, "on_switch");
> +
> +       /* connect to leader diff_reading map */
> +       bpf_map__reuse_fd(evsel->follower_skel->maps.diff_readings, diff_map_fd);
> +
> +       /* set up reading map */
> +       bpf_map__set_max_entries(evsel->follower_skel->maps.accum_readings,
> +                                filter_entry_cnt);
> +       /* set up follower filter based on target */
> +       bpf_map__set_max_entries(evsel->follower_skel->maps.filter,
> +                                filter_entry_cnt);
> +       err = bperf_follower_bpf__load(evsel->follower_skel);
> +       if (err) {
> +               pr_err("Failed to load follower skeleton\n");
> +               bperf_follower_bpf__destroy(evsel->follower_skel);
> +               evsel->follower_skel = NULL;
> +               goto out;
> +       }
> +
> +       for (i = 0; i < filter_entry_cnt; i++) {
> +               int filter_map_fd;
> +               __u32 key;
> +
> +               if (filter_type == BPERF_FILTER_PID ||
> +                   filter_type == BPERF_FILTER_TGID)
> +                       key = evsel->core.threads->map[i].pid;
> +               else if (filter_type == BPERF_FILTER_CPU)
> +                       key = evsel->core.cpus->map[i];
> +               else
> +                       break;
> +
> +               filter_map_fd = bpf_map__fd(evsel->follower_skel->maps.filter);
> +               bpf_map_update_elem(filter_map_fd, &key, &i, BPF_ANY);
> +       }
> +
> +       evsel->follower_skel->bss->type = filter_type;
> +
> +       err = bperf_follower_bpf__attach(evsel->follower_skel);
> +
> +out:
> +       if (err && evsel->bperf_leader_link_fd >= 0)
> +               close(evsel->bperf_leader_link_fd);
> +       if (err && evsel->bperf_leader_prog_fd >= 0)
> +               close(evsel->bperf_leader_prog_fd);
> +       if (diff_map_fd >= 0)
> +               close(diff_map_fd);
> +
> +       flock(attr_map_fd, LOCK_UN);
> +       close(attr_map_fd);
> +
> +       return err;
> +}
> +
> +static int bperf__install_pe(struct evsel *evsel, int cpu, int fd)
> +{
> +       struct bperf_leader_bpf *skel = evsel->leader_skel;
> +
> +       return bpf_map_update_elem(bpf_map__fd(skel->maps.events),
> +                                  &cpu, &fd, BPF_ANY);
> +}
> +
> +/*
> + * trigger the leader prog on each cpu, so the accum_reading map could get
> + * the latest readings.
> + */
> +static int bperf_sync_counters(struct evsel *evsel)
> +{
> +       int num_cpu, i, cpu;
> +
> +       num_cpu = all_cpu_map->nr;
> +       for (i = 0; i < num_cpu; i++) {
> +               cpu = all_cpu_map->map[i];
> +               bperf_trigger_reading(evsel->bperf_leader_prog_fd, cpu);
> +       }
> +       return 0;
> +}
> +
> +static int bperf__enable(struct evsel *evsel)
> +{
> +       evsel->follower_skel->bss->enabled = 1;
> +       return 0;
> +}
> +
> +static int bperf__read(struct evsel *evsel)
> +{
> +       struct bperf_follower_bpf *skel = evsel->follower_skel;
> +       __u32 num_cpu_bpf = cpu__max_cpu();
> +       struct bpf_perf_event_value values[num_cpu_bpf];
> +       int reading_map_fd, err = 0;
> +       __u32 i, j, num_cpu;
> +
> +       bperf_sync_counters(evsel);
> +       reading_map_fd = bpf_map__fd(skel->maps.accum_readings);
> +
> +       for (i = 0; i < bpf_map__max_entries(skel->maps.accum_readings); i++) {
> +               __u32 cpu;
> +
> +               err = bpf_map_lookup_elem(reading_map_fd, &i, values);
> +               if (err)
> +                       goto out;
> +               switch (evsel->follower_skel->bss->type) {
> +               case BPERF_FILTER_GLOBAL:
> +                       assert(i == 0);
> +
> +                       num_cpu = all_cpu_map->nr;
> +                       for (j = 0; j < num_cpu; j++) {
> +                               cpu = all_cpu_map->map[j];
> +                               perf_counts(evsel->counts, cpu, 0)->val = values[cpu].counter;
> +                               perf_counts(evsel->counts, cpu, 0)->ena = values[cpu].enabled;
> +                               perf_counts(evsel->counts, cpu, 0)->run = values[cpu].running;

I'm confused with this.  Does the accum_readings map contain values
for all cpus?  IIUC it has only a single entry but you access it for each cpu.
What am I missing?

Thanks,
Namhyung


> +                       }
> +                       break;
> +               case BPERF_FILTER_CPU:
> +                       cpu = evsel->core.cpus->map[i];
> +                       perf_counts(evsel->counts, i, 0)->val = values[cpu].counter;
> +                       perf_counts(evsel->counts, i, 0)->ena = values[cpu].enabled;
> +                       perf_counts(evsel->counts, i, 0)->run = values[cpu].running;
> +                       break;
> +               case BPERF_FILTER_PID:
> +               case BPERF_FILTER_TGID:
> +                       perf_counts(evsel->counts, 0, i)->val = 0;
> +                       perf_counts(evsel->counts, 0, i)->ena = 0;
> +                       perf_counts(evsel->counts, 0, i)->run = 0;
> +
> +                       for (cpu = 0; cpu < num_cpu_bpf; cpu++) {
> +                               perf_counts(evsel->counts, 0, i)->val += values[cpu].counter;
> +                               perf_counts(evsel->counts, 0, i)->ena += values[cpu].enabled;
> +                               perf_counts(evsel->counts, 0, i)->run += values[cpu].running;
> +                       }
> +                       break;
> +               default:
> +                       break;
> +               }
> +       }
> +out:
> +       return err;
> +}
> +
> +static int bperf__destroy(struct evsel *evsel)
> +{
> +       bperf_follower_bpf__destroy(evsel->follower_skel);
> +       close(evsel->bperf_leader_prog_fd);
> +       close(evsel->bperf_leader_link_fd);
> +       return 0;
> +}
