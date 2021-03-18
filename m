Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E007134072D
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Mar 2021 14:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhCRNu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Mar 2021 09:50:28 -0400
Received: from mail-lf1-f54.google.com ([209.85.167.54]:40706 "EHLO
        mail-lf1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbhCRNuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Mar 2021 09:50:05 -0400
Received: by mail-lf1-f54.google.com with SMTP id a198so4701766lfd.7
        for <linux-kernel@vger.kernel.org>; Thu, 18 Mar 2021 06:50:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qr0LjlvYOjWL9BcfcHukWjlActIav0SKKL8KnnrzfHM=;
        b=erF+9rOPM9yeJNU0w27/WnXcgwypzWfrHXgtmvZQHWfeXeVmawhz3HKBO8qhpG/VNl
         7wre5OfznovRA3PJT1KmSvrE/yB7/KRzRHetgHaOje6VvaZm7JHiF4VmM/g7YzqBzuzk
         CVzraJX3KiGrsDdPGPey33RvAxYoLsBJuovUyWyYJeKUEQD6sThk7RbcKqMS54fz6w/r
         a10ECxOgry/9tgnAoWyInPYM9Qu63C6XlUsjPcUt9agqiJYcjt6jQVQvcBfVkLyrx9ZA
         oyn9duf9ZkyXxm23KEzjtuKYZmLDwDpZUkA2cN1+eA+nFDJxXNavA8IrJ8g6ywLIiZ5j
         xvNQ==
X-Gm-Message-State: AOAM530ZESXSpBAx+/jw/uKNQ4SIPZDE3EK+jHp0bfJihUMR/wqG6xs9
        nwwLNSdZv5AKlurKoR0YcImhqnPPu8JzEzA1UnzLzipq
X-Google-Smtp-Source: ABdhPJycA26ICRuRPLPld3/NqtonoVFbABEZxIrn4DGNhoQHlpFkKqrLkwoAUfKJ1tsTOnx8/RC2d5HOAIN1dO+XNtg=
X-Received: by 2002:ac2:51b4:: with SMTP id f20mr2242458lfk.509.1616075404574;
 Thu, 18 Mar 2021 06:50:04 -0700 (PDT)
MIME-Version: 1.0
References: <20210316211837.910506-1-songliubraving@fb.com>
 <20210316211837.910506-2-songliubraving@fb.com> <CAM9d7cgqqj5_Koe_dxBxsEXqLFS6d8VOoSwkiVaEO79V55JcxQ@mail.gmail.com>
 <5816B9E5-1664-4D66-9128-EFC2EEE089B2@fb.com>
In-Reply-To: <5816B9E5-1664-4D66-9128-EFC2EEE089B2@fb.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Thu, 18 Mar 2021 22:49:53 +0900
Message-ID: <CAM9d7cg7PyKjdWFmv_0B+sz4TDciGGyNkRTC1p+DoXBOn-xXRg@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] perf-stat: introduce bperf, share hardware PMCs
 with BPF
To:     Song Liu <songliubraving@fb.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Team <Kernel-team@fb.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 18, 2021 at 4:22 PM Song Liu <songliubraving@fb.com> wrote:
>
>
>
> > On Mar 17, 2021, at 10:54 PM, Namhyung Kim <namhyung@kernel.org> wrote:
> >
>
> [...]
>
> >> +
> >> +static int bperf_reload_leader_program(struct evsel *evsel, int attr_map_fd,
> >> +                                      struct perf_event_attr_map_entry *entry)
> >> +{
> >> +       struct bperf_leader_bpf *skel = bperf_leader_bpf__open();
> >> +       int link_fd, diff_map_fd, err;
> >> +       struct bpf_link *link = NULL;
> >> +
> >> +       if (!skel) {
> >> +               pr_err("Failed to open leader skeleton\n");
> >> +               return -1;
> >> +       }
> >> +
> >> +       bpf_map__resize(skel->maps.events, libbpf_num_possible_cpus());
> >> +       err = bperf_leader_bpf__load(skel);
> >> +       if (err) {
> >> +               pr_err("Failed to load leader skeleton\n");
> >> +               goto out;
> >> +       }
> >> +
> >> +       err = -1;
> >> +       link = bpf_program__attach(skel->progs.on_switch);
> >> +       if (!link) {
> >> +               pr_err("Failed to attach leader program\n");
> >> +               goto out;
> >> +       }
> >> +
> >> +       link_fd = bpf_link__fd(link);
> >> +       diff_map_fd = bpf_map__fd(skel->maps.diff_readings);
> >> +       entry->link_id = bpf_link_get_id(link_fd);
> >> +       entry->diff_map_id = bpf_map_get_id(diff_map_fd);
> >> +       err = bpf_map_update_elem(attr_map_fd, &evsel->core.attr, entry, BPF_ANY);
> >> +       assert(err == 0);
> >> +
> >> +       evsel->bperf_leader_link_fd = bpf_link_get_fd_by_id(entry->link_id);
> >> +       assert(evsel->bperf_leader_link_fd >= 0);
> >
> > Isn't it the same as link_fd?
>
> This is a different fd on the same link.

Ok

>
> >
> >> +
> >> +       /*
> >> +        * save leader_skel for install_pe, which is called within
> >> +        * following evsel__open_per_cpu call
> >> +        */
> >> +       evsel->leader_skel = skel;
> >> +       evsel__open_per_cpu(evsel, all_cpu_map, -1);
> >> +
> >> +out:
> >> +       bperf_leader_bpf__destroy(skel);
> >> +       bpf_link__destroy(link);
> >
> > Why do we destroy it?  Is it because we get an another reference?
>
> Yes. We only need evsel->bperf_leader_link_fd to keep the whole
> skeleton attached.
>
> When multiple perf-stat sessions are sharing the leader skeleton,
> only the first one loads the leader skeleton, by calling
> bperf_reload_leader_program(). Other sessions simply hold a fd to
> the bpf_link. More explanation in bperf__load() below.

Ok.

>
>
> >
> >> +       return err;
> >> +}
> >> +
> >> +static int bperf__load(struct evsel *evsel, struct target *target)
> >> +{
> >> +       struct perf_event_attr_map_entry entry = {0xffffffff, 0xffffffff};
> >> +       int attr_map_fd, diff_map_fd = -1, err;
> >> +       enum bperf_filter_type filter_type;
> >> +       __u32 filter_entry_cnt, i;
> >> +
> >> +       if (bperf_check_target(evsel, target, &filter_type, &filter_entry_cnt))
> >> +               return -1;
> >> +
> >> +       if (!all_cpu_map) {
> >> +               all_cpu_map = perf_cpu_map__new(NULL);
> >> +               if (!all_cpu_map)
> >> +                       return -1;
> >> +       }
> >> +
> >> +       evsel->bperf_leader_prog_fd = -1;
> >> +       evsel->bperf_leader_link_fd = -1;
> >> +
> >> +       /*
> >> +        * Step 1: hold a fd on the leader program and the bpf_link, if
> >> +        * the program is not already gone, reload the program.
> >> +        * Use flock() to ensure exclusive access to the perf_event_attr
> >> +        * map.
> >> +        */
> >> +       attr_map_fd = bperf_lock_attr_map(target);
> >> +       if (attr_map_fd < 0) {
> >> +               pr_err("Failed to lock perf_event_attr map\n");
> >> +               return -1;
> >> +       }
> >> +
> >> +       err = bpf_map_lookup_elem(attr_map_fd, &evsel->core.attr, &entry);
> >> +       if (err) {
> >> +               err = bpf_map_update_elem(attr_map_fd, &evsel->core.attr, &entry, BPF_ANY);
> >> +               if (err)
> >> +                       goto out;
> >> +       }
> >> +
> >> +       evsel->bperf_leader_link_fd = bpf_link_get_fd_by_id(entry.link_id);
> >> +       if (evsel->bperf_leader_link_fd < 0 &&
> >> +           bperf_reload_leader_program(evsel, attr_map_fd, &entry))
> >> +               goto out;
>
> Continue with previous explanation. In bperf_reload_leader_program(),
> we open another reference to the link, and destroy the skeleton. This
> brings the code to the same state as evsel->bperf_leader_link_fd >=
> condition above.

Thanks for the explanation.

>
> >> +
> >> +       /*
> >> +        * The bpf_link holds reference to the leader program, and the
> >> +        * leader program holds reference to the maps. Therefore, if
> >> +        * link_id is valid, diff_map_id should also be valid.
> >> +        */
> >> +       evsel->bperf_leader_prog_fd = bpf_prog_get_fd_by_id(
> >> +               bpf_link_get_prog_id(evsel->bperf_leader_link_fd));
> >> +       assert(evsel->bperf_leader_prog_fd >= 0);
> >> +
> >> +       diff_map_fd = bpf_map_get_fd_by_id(entry.diff_map_id);
> >> +       assert(diff_map_fd >= 0);
> >> +
>
> [...]
>
> >> +static int bperf__read(struct evsel *evsel)
> >> +{
> >> +       struct bperf_follower_bpf *skel = evsel->follower_skel;
> >> +       __u32 num_cpu_bpf = cpu__max_cpu();
> >> +       struct bpf_perf_event_value values[num_cpu_bpf];
> >> +       int reading_map_fd, err = 0;
> >> +       __u32 i, j, num_cpu;
> >> +
> >> +       bperf_sync_counters(evsel);
> >> +       reading_map_fd = bpf_map__fd(skel->maps.accum_readings);
> >> +
> >> +       for (i = 0; i < bpf_map__max_entries(skel->maps.accum_readings); i++) {
> >> +               __u32 cpu;
> >> +
> >> +               err = bpf_map_lookup_elem(reading_map_fd, &i, values);
> >> +               if (err)
> >> +                       goto out;
> >> +               switch (evsel->follower_skel->bss->type) {
> >> +               case BPERF_FILTER_GLOBAL:
> >> +                       assert(i == 0);
> >> +
> >> +                       num_cpu = all_cpu_map->nr;
> >> +                       for (j = 0; j < num_cpu; j++) {
> >> +                               cpu = all_cpu_map->map[j];
> >> +                               perf_counts(evsel->counts, cpu, 0)->val = values[cpu].counter;
> >> +                               perf_counts(evsel->counts, cpu, 0)->ena = values[cpu].enabled;
> >> +                               perf_counts(evsel->counts, cpu, 0)->run = values[cpu].running;
> >
> > I'm confused with this.  Does the accum_readings map contain values
> > for all cpus?  IIUC it has only a single entry but you access it for each cpu.
> > What am I missing?
>
> accumulated_reading is a percpu array. In this case, each cpu has its own
> bpf_perf_event_value with index 0. The BPF program could only access the
> data on current cpu. When reading from use space, we get #-of-cpus entries
> for index 0.
>
> Does this make sense?

Yep, I didn't know it returns all values when reading from user space.  Then
I think per cpu event doesn't have many entries too.  Like the global case
it can simply put the value with key 0, no?

Thanks,
Namhyung
