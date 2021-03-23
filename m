Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 530F734679A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Mar 2021 19:28:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbhCWS1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 14:27:40 -0400
Received: from mail.kernel.org ([198.145.29.99]:48616 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231426AbhCWS1d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 14:27:33 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 07656619C1;
        Tue, 23 Mar 2021 18:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1616524052;
        bh=K4Wu6c0EXMARL4SHncupNTL/FerZxJ7miAodhyNujS0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VbOL70shnG5XyohtUz6mqbpsAKrGKSx/zP0v9BRbm4tUXdHX9ZU5oFKJglVA7h+Y8
         DlcPIiuLUcDL8LdIzmsbWQlFqYVTDXO8YE1zgWOYJxKY5GCohQsRSUir2QV0dI0/aN
         klqpr5ilSdATpkk6GQwQBx0v5JF2JFImVLZEHhVxavNh0kSLk9g9zpZDIu5rWbouly
         EZW1YX/boduKkie7Lrnw73R3q1YM+SueVb+iD71iw3Hc7txULM1sgh/8HBwSx7Qmk6
         kzaaoP40gR8eXWXzJtuKWdAt3LZiku4vAtSfymMzeaELE+l+NaDDoFN7gE//f/5G5v
         6BT2DRvicK1hA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 032ED40647; Tue, 23 Mar 2021 15:27:29 -0300 (-03)
Date:   Tue, 23 Mar 2021 15:27:29 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <songliubraving@fb.com>, Jiri Olsa <jolsa@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com, acme@redhat.com,
        namhyung@kernel.org, jolsa@kernel.org
Subject: Re: [PATCH v2 1/3] perf-stat: introduce bperf, share hardware PMCs
 with BPF
Message-ID: <YFozES0GFQsqXtJp@kernel.org>
References: <20210316211837.910506-1-songliubraving@fb.com>
 <20210316211837.910506-2-songliubraving@fb.com>
 <YFPC4UbLWzTuzyER@krava>
 <YFTwdWxUvqHDNe1x@kernel.org>
 <YFneUHDiAt8Rg0cc@kernel.org>
 <YFnhFugY4wmchhwi@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YFnhFugY4wmchhwi@kernel.org>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Mar 23, 2021 at 09:37:42AM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Mar 23, 2021 at 09:25:52AM -0300, Arnaldo Carvalho de Melo escreveu:
> > Em Fri, Mar 19, 2021 at 03:41:57PM -0300, Arnaldo Carvalho de Melo escreveu:
> > > Em Thu, Mar 18, 2021 at 10:15:13PM +0100, Jiri Olsa escreveu:
> > > > On Tue, Mar 16, 2021 at 02:18:35PM -0700, Song Liu wrote:
> > > > > bperf is off by default. To enable it, pass --bpf-counters option to
> > > > > perf-stat. bperf uses a BPF hashmap to share information about BPF
> > > > > programs and maps used by bperf. This map is pinned to bpffs. The default
> > > > > path is /sys/fs/bpf/perf_attr_map. The user could change the path with
> > > > > option --bpf-attr-map.
> > > > > 
> > > > > Signed-off-by: Song Liu <songliubraving@fb.com>
> > > > 
> > > > Reviewed-by: Jiri Olsa <jolsa@redhat.com>
> > > 
> > > After applying just this first patch in the series I'm getting this
> > > after a 'make -C tools/ clean', now I'm checking if I need some new
> > > clang, ideas?
> > 
> > Works now with clang from fedora 33, I was using a locally built, older,
> > now I get this when trying as non-root, expected, but we need to improve
> > the wording.
> 
> Fails as root as well, investigating:
> 
> [root@five ~]# ls -lad /sys/fs/bpf/
> drwx-----T. 2 root root 0 Mar 23 06:03 /sys/fs/bpf/
> [root@five ~]# strace -e bpf perf stat --bpf-counters sleep 1
> bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_HASH, key_size=120, value_size=8, max_entries=16, map_flags=0, inner_map_fd=0, map_name="", map_ifindex=0, btf_fd=0, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = -1 EPERM (Operation not permitted)
> Failed to lock perf_event_attr map
> --- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_KILLED, si_pid=13916, si_uid=0, si_status=SIGTERM, si_utime=0, si_stime=0} ---
> +++ exited with 255 +++
> [root@five ~]#
>  
> > [acme@five perf]$ perf stat --bpf-counters sleep 1
> > Failed to lock perf_event_attr map
> > [acme@five perf]$

Now it works, on 5.12-rc2+

[root@five pahole]# perf stat --bpf-counters sleep 1
libbpf: elf: skipping unrecognized data section(7) .eh_frame
libbpf: elf: skipping relo section(12) .rel.eh_frame for section(7) .eh_frame
libbpf: elf: skipping unrecognized data section(8) .eh_frame
libbpf: elf: skipping relo section(13) .rel.eh_frame for section(8) .eh_frame
libbpf: elf: skipping unrecognized data section(7) .eh_frame
libbpf: elf: skipping relo section(12) .rel.eh_frame for section(7) .eh_frame
libbpf: elf: skipping unrecognized data section(8) .eh_frame
libbpf: elf: skipping relo section(13) .rel.eh_frame for section(8) .eh_frame
libbpf: elf: skipping unrecognized data section(7) .eh_frame
libbpf: elf: skipping relo section(12) .rel.eh_frame for section(7) .eh_frame
libbpf: elf: skipping unrecognized data section(8) .eh_frame
libbpf: elf: skipping relo section(13) .rel.eh_frame for section(8) .eh_frame
libbpf: elf: skipping unrecognized data section(7) .eh_frame
libbpf: elf: skipping relo section(12) .rel.eh_frame for section(7) .eh_frame
libbpf: elf: skipping unrecognized data section(8) .eh_frame
libbpf: elf: skipping relo section(13) .rel.eh_frame for section(8) .eh_frame
libbpf: elf: skipping unrecognized data section(7) .eh_frame
libbpf: elf: skipping relo section(12) .rel.eh_frame for section(7) .eh_frame
libbpf: elf: skipping unrecognized data section(8) .eh_frame
libbpf: elf: skipping relo section(13) .rel.eh_frame for section(8) .eh_frame
libbpf: elf: skipping unrecognized data section(7) .eh_frame
libbpf: elf: skipping relo section(12) .rel.eh_frame for section(7) .eh_frame
libbpf: elf: skipping unrecognized data section(8) .eh_frame
libbpf: elf: skipping relo section(13) .rel.eh_frame for section(8) .eh_frame
libbpf: elf: skipping unrecognized data section(7) .eh_frame
libbpf: elf: skipping relo section(12) .rel.eh_frame for section(7) .eh_frame
libbpf: elf: skipping unrecognized data section(8) .eh_frame
libbpf: elf: skipping relo section(13) .rel.eh_frame for section(8) .eh_frame
libbpf: elf: skipping unrecognized data section(7) .eh_frame
libbpf: elf: skipping relo section(12) .rel.eh_frame for section(7) .eh_frame
libbpf: elf: skipping unrecognized data section(8) .eh_frame
libbpf: elf: skipping relo section(13) .rel.eh_frame for section(8) .eh_frame
libbpf: elf: skipping unrecognized data section(7) .eh_frame
libbpf: elf: skipping relo section(12) .rel.eh_frame for section(7) .eh_frame
libbpf: elf: skipping unrecognized data section(8) .eh_frame
libbpf: elf: skipping relo section(13) .rel.eh_frame for section(8) .eh_frame
libbpf: elf: skipping unrecognized data section(7) .eh_frame
libbpf: elf: skipping relo section(12) .rel.eh_frame for section(7) .eh_frame
libbpf: elf: skipping unrecognized data section(8) .eh_frame
libbpf: elf: skipping relo section(13) .rel.eh_frame for section(8) .eh_frame

 Performance counter stats for 'sleep 1':

              0.84 msec task-clock                #    0.001 CPUs utilized
                 3      context-switches          #    3.589 K/sec
                 2      cpu-migrations            #    2.393 K/sec
                67      page-faults               #   80.164 K/sec
         2,760,235      cycles                    #    3.303 GHz                      (88.36%)
           241,055      stalled-cycles-frontend   #    8.73% frontend cycles idle     (45.93%)
         1,251,751      stalled-cycles-backend    #   45.35% backend cycles idle      (65.67%)
         2,340,813      instructions              #    0.85  insn per cycle
                                                  #    0.53  stalled cycles per insn
           459,088      branches                  #  549.289 M/sec
            12,243      branch-misses             #    2.67% of all branches

       1.000928326 seconds time elapsed

       0.000881000 seconds user
       0.000000000 seconds sys


[root@five pahole]# clang --version
clang version 11.0.0 (Fedora 11.0.0-2.fc33)
Target: x86_64-unknown-linux-gnu
Thread model: posix
InstalledDir: /usr/bin
[root@five pahole]# uname -a
Linux five 5.12.0-rc2+ #2 SMP Tue Mar 23 12:51:43 -03 2021 x86_64 x86_64 x86_64 GNU/Linux
[root@five pahole]#


Full BPF setup, lotsa syscalls:

[root@five pahole]# strace -e bpf perf stat --bpf-counters sleep 1
bpf(BPF_OBJ_GET, {pathname="/sys/fs/bpf/perf_attr_map", bpf_fd=0, file_flags=0}, 120) = 3
bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=3, key=0x1b39760, value=0x7ffda32551a8, flags=BPF_ANY}, 120) = 0
bpf(BPF_LINK_GET_FD_BY_ID, 0x7ffda32550e0, 120) = -1 ENOENT (No such file or directory)
libbpf: elf: skipping unrecognized data section(7) .eh_frame
libbpf: elf: skipping relo section(12) .rel.eh_frame for section(7) .eh_frame
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=2, insns=0x7ffda3254ff0, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0, prog_name="", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0, func_info_rec_size=0, func_info=NULL, func_info_cnt=0, line_info_rec_size=0, line_info=NULL, line_info_cnt=0, attach_btf_id=0, attach_prog_fd=0}, 120) = 4
bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0\20\0\0\0\20\0\0\0\5\0\0\0\1\0\0\0\0\0\0\1"..., btf_log_buf=NULL, btf_size=45, btf_log_size=0, btf_log_level=0}, 120) = 4
bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0000\0\0\0000\0\0\0\t\0\0\0\1\0\0\0\0\0\0\1"..., btf_log_buf=NULL, btf_size=81, btf_log_size=0, btf_log_level=0}, 120) = 4
bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\08\0\0\08\0\0\0\t\0\0\0\0\0\0\0\0\0\0\1"..., btf_log_buf=NULL, btf_size=89, btf_log_size=0, btf_log_level=0}, 120) = 4
bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0000\0\0\0000\0\0\0\t\0\0\0\1\0\0\0\0\0\0\1"..., btf_log_buf=NULL, btf_size=81, btf_log_size=0, btf_log_level=0}, 120) = 4
bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0D\2\0\0D\2\0\0\356\2\0\0\0\0\0\0\0\0\0\2"..., btf_log_buf=NULL, btf_size=1354, btf_log_size=0, btf_log_level=0}, 120) = 4
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=2, insns=0x7ffda3254c90, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0, prog_name="test", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0, func_info_rec_size=0, func_info=NULL, func_info_cnt=0, line_info_rec_size=0, line_info=NULL, line_info_cnt=0, attach_btf_id=0, attach_prog_fd=0}, 120) = 5
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERF_EVENT_ARRAY, key_size=4, value_size=4, max_entries=24, map_flags=BPF_F_PRESERVE_ELEMS, inner_map_fd=0, map_name="events", map_ifindex=0, btf_fd=4, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 5
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERCPU_ARRAY, key_size=4, value_size=24, max_entries=1, map_flags=0, inner_map_fd=0, map_name="prev_readings", map_ifindex=0, btf_fd=4, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 7
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERCPU_ARRAY, key_size=4, value_size=24, max_entries=1, map_flags=0, inner_map_fd=0, map_name="diff_readings", map_ifindex=0, btf_fd=4, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 8
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_CGROUP_SOCK, insn_cnt=2, insns=0x7ffda3254c90, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0, prog_name="", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_SOCK_CREATE, prog_btf_fd=0, func_info_rec_size=0, func_info=NULL, func_info_cnt=0, line_info_rec_size=0, line_info=NULL, line_info_cnt=0, attach_btf_id=0, attach_prog_fd=0}, 120) = 9
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_RAW_TRACEPOINT, insn_cnt=48, insns=0x1b7fd00, license="Dual BSD/GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(5, 12, 0), prog_flags=0, prog_name="on_switch", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=4, func_info_rec_size=8, func_info=0x1b7e6c0, func_info_cnt=1, line_info_rec_size=16, line_info=0x1b761b0, line_info_cnt=25, attach_btf_id=0, attach_prog_fd=0}, 120) = 9
bpf(BPF_RAW_TRACEPOINT_OPEN, {raw_tracepoint={name="sched_switch", prog_fd=9}}, 120) = 10
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=10, info_len=32, info=0x7ffda32551b0}}, 120) = 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=8, info_len=80, info=0x7ffda3255200}}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=3, key=0x1b39760, value=0x7ffda32551a8, flags=BPF_ANY}, 120) = 0
bpf(BPF_LINK_GET_FD_BY_ID, 0x7ffda32550e0, 120) = 11
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=5, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=5, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=5, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=5, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=5, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=5, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=5, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=5, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=5, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=5, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=5, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=5, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=5, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=5, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=5, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=5, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=5, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=5, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=5, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=5, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=5, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=5, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=5, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=5, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=11, info_len=32, info=0x7ffda32551b0}}, 120) = 0
bpf(BPF_PROG_GET_FD_BY_ID, {prog_id=192, next_id=0, open_flags=0}, 120) = 4
bpf(BPF_MAP_GET_FD_BY_ID, {map_id=195, next_id=0, open_flags=0}, 120) = 5
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=4, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
libbpf: elf: skipping unrecognized data section(8) .eh_frame
libbpf: elf: skipping relo section(13) .rel.eh_frame for section(8) .eh_frame
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=4, info_len=216, info=0x7ffda3254f50}}, 120) = 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=4, info_len=216, info=0x1b72d20}}, 120) = 0
bpf(BPF_BTF_GET_FD_BY_ID, {btf_id=305}, 120) = 7
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=7, info_len=32, info=0x7ffda3255000}}, 120) = 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=5, info_len=80, info=0x7ffda32550f0}}, 120) = 0
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=2, insns=0x7ffda3254ff0, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0, prog_name="", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0, func_info_rec_size=0, func_info=NULL, func_info_cnt=0, line_info_rec_size=0, line_info=NULL, line_info_cnt=0, attach_btf_id=0, attach_prog_fd=0}, 120) = 8
bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0\204\2\0\0\204\2\0\0\250\3\0\0\0\0\0\0\0\0\0\2"..., btf_log_buf=NULL, btf_size=1604, btf_log_size=0, btf_log_level=0}, 120) = 8
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_ARRAY, key_size=4, value_size=32, max_entries=1, map_flags=0, inner_map_fd=0, map_name="", map_ifindex=0, btf_fd=0, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 9
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=5, insns=0x7ffda3254e30, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0, prog_name="", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0, func_info_rec_size=0, func_info=NULL, func_info_cnt=0, line_info_rec_size=0, line_info=NULL, line_info_cnt=0, attach_btf_id=0, attach_prog_fd=0}, 120) = 10
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_ARRAY, key_size=4, value_size=4, max_entries=1, map_flags=BPF_F_MMAPABLE, inner_map_fd=0, map_name="", map_ifindex=0, btf_fd=0, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 9
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERCPU_ARRAY, key_size=4, value_size=24, max_entries=1, map_flags=0, inner_map_fd=0, map_name="accum_readings", map_ifindex=0, btf_fd=8, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 9
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_HASH, key_size=4, value_size=4, max_entries=1, map_flags=0, inner_map_fd=0, map_name="filter", map_ifindex=0, btf_fd=8, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 10
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_ARRAY, key_size=4, value_size=8, max_entries=1, map_flags=BPF_F_MMAPABLE, inner_map_fd=0, map_name="bperf_fo.bss", map_ifindex=0, btf_fd=8, btf_key_type_id=0, btf_value_type_id=27, btf_vmlinux_value_type_id=0}, 120) = 36
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=36, key=0x7ffda3254e50, value=0x7f0a61b70000, flags=BPF_ANY}, 120) = 0
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_TRACING, insn_cnt=58, insns=0x1b35650, license="Dual BSD/GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(5, 12, 0), prog_flags=0, prog_name="fexit_XXX", prog_ifindex=0, expected_attach_type=BPF_TRACE_FEXIT, prog_btf_fd=8, func_info_rec_size=8, func_info=0x1b80000, func_info_cnt=1, line_info_rec_size=16, line_info=0x1b75420, line_info_cnt=28, attach_btf_id=22, attach_prog_fd=4}, 120) = 37
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=10, key=0x7ffda32551b0, value=0x7ffda32551a4, flags=BPF_ANY}, 120) = 0
bpf(BPF_RAW_TRACEPOINT_OPEN, {raw_tracepoint={name=NULL, prog_fd=37}}, 120) = 38
bpf(BPF_OBJ_GET, {pathname="/sys/fs/bpf/perf_attr_map", bpf_fd=0, file_flags=0}, 120) = 3
bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=3, key=0x1b392b0, value=0x7ffda32551a8, flags=BPF_ANY}, 120) = 0
bpf(BPF_LINK_GET_FD_BY_ID, 0x7ffda32550e0, 120) = -1 ENOENT (No such file or directory)
libbpf: elf: skipping unrecognized data section(7) .eh_frame
libbpf: elf: skipping relo section(12) .rel.eh_frame for section(7) .eh_frame
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=2, insns=0x7ffda3254ff0, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0, prog_name="", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0, func_info_rec_size=0, func_info=NULL, func_info_cnt=0, line_info_rec_size=0, line_info=NULL, line_info_cnt=0, attach_btf_id=0, attach_prog_fd=0}, 120) = 5
bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0D\2\0\0D\2\0\0\356\2\0\0\0\0\0\0\0\0\0\2"..., btf_log_buf=NULL, btf_size=1354, btf_log_size=0, btf_log_level=0}, 120) = 5
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERF_EVENT_ARRAY, key_size=4, value_size=4, max_entries=24, map_flags=BPF_F_PRESERVE_ELEMS, inner_map_fd=0, map_name="events", map_ifindex=0, btf_fd=5, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 39
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERCPU_ARRAY, key_size=4, value_size=24, max_entries=1, map_flags=0, inner_map_fd=0, map_name="prev_readings", map_ifindex=0, btf_fd=5, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 40
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERCPU_ARRAY, key_size=4, value_size=24, max_entries=1, map_flags=0, inner_map_fd=0, map_name="diff_readings", map_ifindex=0, btf_fd=5, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 41
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_RAW_TRACEPOINT, insn_cnt=48, insns=0x1b7fd00, license="Dual BSD/GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(5, 12, 0), prog_flags=0, prog_name="on_switch", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=5, func_info_rec_size=8, func_info=0x1b78bb0, func_info_cnt=1, line_info_rec_size=16, line_info=0x1b761b0, line_info_cnt=25, attach_btf_id=0, attach_prog_fd=0}, 120) = 42
bpf(BPF_RAW_TRACEPOINT_OPEN, {raw_tracepoint={name="sched_switch", prog_fd=42}}, 120) = 43
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=43, info_len=32, info=0x7ffda32551b0}}, 120) = 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=41, info_len=80, info=0x7ffda3255200}}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=3, key=0x1b392b0, value=0x7ffda32551a8, flags=BPF_ANY}, 120) = 0
bpf(BPF_LINK_GET_FD_BY_ID, 0x7ffda32550e0, 120) = 44
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=39, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=39, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=39, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=39, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=39, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=39, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=39, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=39, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=39, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=39, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=39, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=39, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=39, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=39, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=39, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=39, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=39, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=39, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=39, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=39, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=39, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=39, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=39, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=39, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=44, info_len=32, info=0x7ffda32551b0}}, 120) = 0
bpf(BPF_PROG_GET_FD_BY_ID, {prog_id=197, next_id=0, open_flags=0}, 120) = 5
bpf(BPF_MAP_GET_FD_BY_ID, {map_id=203, next_id=0, open_flags=0}, 120) = 39
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=5, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
libbpf: elf: skipping unrecognized data section(8) .eh_frame
libbpf: elf: skipping relo section(13) .rel.eh_frame for section(8) .eh_frame
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=5, info_len=216, info=0x7ffda3254f50}}, 120) = 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=5, info_len=216, info=0x1b72d20}}, 120) = 0
bpf(BPF_BTF_GET_FD_BY_ID, {btf_id=307}, 120) = 40
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=40, info_len=32, info=0x7ffda3255000}}, 120) = 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=39, info_len=80, info=0x7ffda32550f0}}, 120) = 0
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=2, insns=0x7ffda3254ff0, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0, prog_name="", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0, func_info_rec_size=0, func_info=NULL, func_info_cnt=0, line_info_rec_size=0, line_info=NULL, line_info_cnt=0, attach_btf_id=0, attach_prog_fd=0}, 120) = 41
bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0\204\2\0\0\204\2\0\0\250\3\0\0\0\0\0\0\0\0\0\2"..., btf_log_buf=NULL, btf_size=1604, btf_log_size=0, btf_log_level=0}, 120) = 41
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERCPU_ARRAY, key_size=4, value_size=24, max_entries=1, map_flags=0, inner_map_fd=0, map_name="accum_readings", map_ifindex=0, btf_fd=41, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 42
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_HASH, key_size=4, value_size=4, max_entries=1, map_flags=0, inner_map_fd=0, map_name="filter", map_ifindex=0, btf_fd=41, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 43
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_ARRAY, key_size=4, value_size=8, max_entries=1, map_flags=BPF_F_MMAPABLE, inner_map_fd=0, map_name="bperf_fo.bss", map_ifindex=0, btf_fd=41, btf_key_type_id=0, btf_value_type_id=27, btf_vmlinux_value_type_id=0}, 120) = 69
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=69, key=0x7ffda3254e50, value=0x7f0a61b6f000, flags=BPF_ANY}, 120) = 0
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_TRACING, insn_cnt=58, insns=0x1b35650, license="Dual BSD/GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(5, 12, 0), prog_flags=0, prog_name="fexit_XXX", prog_ifindex=0, expected_attach_type=BPF_TRACE_FEXIT, prog_btf_fd=41, func_info_rec_size=8, func_info=0x1b805c0, func_info_cnt=1, line_info_rec_size=16, line_info=0x1b78100, line_info_cnt=28, attach_btf_id=22, attach_prog_fd=5}, 120) = 70
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=43, key=0x7ffda32551b0, value=0x7ffda32551a4, flags=BPF_ANY}, 120) = 0
bpf(BPF_RAW_TRACEPOINT_OPEN, {raw_tracepoint={name=NULL, prog_fd=70}}, 120) = 71
bpf(BPF_OBJ_GET, {pathname="/sys/fs/bpf/perf_attr_map", bpf_fd=0, file_flags=0}, 120) = 3
bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=3, key=0x1b36840, value=0x7ffda32551a8, flags=BPF_ANY}, 120) = 0
bpf(BPF_LINK_GET_FD_BY_ID, 0x7ffda32550e0, 120) = -1 ENOENT (No such file or directory)
libbpf: elf: skipping unrecognized data section(7) .eh_frame
libbpf: elf: skipping relo section(12) .rel.eh_frame for section(7) .eh_frame
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=2, insns=0x7ffda3254ff0, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0, prog_name="", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0, func_info_rec_size=0, func_info=NULL, func_info_cnt=0, line_info_rec_size=0, line_info=NULL, line_info_cnt=0, attach_btf_id=0, attach_prog_fd=0}, 120) = 39
bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0D\2\0\0D\2\0\0\356\2\0\0\0\0\0\0\0\0\0\2"..., btf_log_buf=NULL, btf_size=1354, btf_log_size=0, btf_log_level=0}, 120) = 39
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERF_EVENT_ARRAY, key_size=4, value_size=4, max_entries=24, map_flags=BPF_F_PRESERVE_ELEMS, inner_map_fd=0, map_name="events", map_ifindex=0, btf_fd=39, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 72
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERCPU_ARRAY, key_size=4, value_size=24, max_entries=1, map_flags=0, inner_map_fd=0, map_name="prev_readings", map_ifindex=0, btf_fd=39, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 73
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERCPU_ARRAY, key_size=4, value_size=24, max_entries=1, map_flags=0, inner_map_fd=0, map_name="diff_readings", map_ifindex=0, btf_fd=39, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 74
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_RAW_TRACEPOINT, insn_cnt=48, insns=0x1b7fd00, license="Dual BSD/GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(5, 12, 0), prog_flags=0, prog_name="on_switch", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=39, func_info_rec_size=8, func_info=0x1b813d0, func_info_cnt=1, line_info_rec_size=16, line_info=0x1b761b0, line_info_cnt=25, attach_btf_id=0, attach_prog_fd=0}, 120) = 75
bpf(BPF_RAW_TRACEPOINT_OPEN, {raw_tracepoint={name="sched_switch", prog_fd=75}}, 120) = 76
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=76, info_len=32, info=0x7ffda32551b0}}, 120) = 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=74, info_len=80, info=0x7ffda3255200}}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=3, key=0x1b36840, value=0x7ffda32551a8, flags=BPF_ANY}, 120) = 0
bpf(BPF_LINK_GET_FD_BY_ID, 0x7ffda32550e0, 120) = 77
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=72, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=72, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=72, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=72, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=72, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=72, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=72, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=72, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=72, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=72, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=72, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=72, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=72, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=72, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=72, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=72, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=72, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=72, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=72, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=72, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=72, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=72, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=72, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=72, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=77, info_len=32, info=0x7ffda32551b0}}, 120) = 0
bpf(BPF_PROG_GET_FD_BY_ID, {prog_id=201, next_id=0, open_flags=0}, 120) = 39
bpf(BPF_MAP_GET_FD_BY_ID, {map_id=209, next_id=0, open_flags=0}, 120) = 72
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=39, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
libbpf: elf: skipping unrecognized data section(8) .eh_frame
libbpf: elf: skipping relo section(13) .rel.eh_frame for section(8) .eh_frame
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=39, info_len=216, info=0x7ffda3254f50}}, 120) = 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=39, info_len=216, info=0x1b72d20}}, 120) = 0
bpf(BPF_BTF_GET_FD_BY_ID, {btf_id=309}, 120) = 73
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=73, info_len=32, info=0x7ffda3255000}}, 120) = 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=72, info_len=80, info=0x7ffda32550f0}}, 120) = 0
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=2, insns=0x7ffda3254ff0, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0, prog_name="", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0, func_info_rec_size=0, func_info=NULL, func_info_cnt=0, line_info_rec_size=0, line_info=NULL, line_info_cnt=0, attach_btf_id=0, attach_prog_fd=0}, 120) = 74
bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0\204\2\0\0\204\2\0\0\250\3\0\0\0\0\0\0\0\0\0\2"..., btf_log_buf=NULL, btf_size=1604, btf_log_size=0, btf_log_level=0}, 120) = 74
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERCPU_ARRAY, key_size=4, value_size=24, max_entries=1, map_flags=0, inner_map_fd=0, map_name="accum_readings", map_ifindex=0, btf_fd=74, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 75
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_HASH, key_size=4, value_size=4, max_entries=1, map_flags=0, inner_map_fd=0, map_name="filter", map_ifindex=0, btf_fd=74, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 76
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_ARRAY, key_size=4, value_size=8, max_entries=1, map_flags=BPF_F_MMAPABLE, inner_map_fd=0, map_name="bperf_fo.bss", map_ifindex=0, btf_fd=74, btf_key_type_id=0, btf_value_type_id=27, btf_vmlinux_value_type_id=0}, 120) = 102
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=102, key=0x7ffda3254e50, value=0x7f0a61b6e000, flags=BPF_ANY}, 120) = 0
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_TRACING, insn_cnt=58, insns=0x1b35650, license="Dual BSD/GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(5, 12, 0), prog_flags=0, prog_name="fexit_XXX", prog_ifindex=0, expected_attach_type=BPF_TRACE_FEXIT, prog_btf_fd=74, func_info_rec_size=8, func_info=0x1b79b40, func_info_cnt=1, line_info_rec_size=16, line_info=0x1b786a0, line_info_cnt=28, attach_btf_id=22, attach_prog_fd=39}, 120) = 103
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=76, key=0x7ffda32551b0, value=0x7ffda32551a4, flags=BPF_ANY}, 120) = 0
bpf(BPF_RAW_TRACEPOINT_OPEN, {raw_tracepoint={name=NULL, prog_fd=103}}, 120) = 104
bpf(BPF_OBJ_GET, {pathname="/sys/fs/bpf/perf_attr_map", bpf_fd=0, file_flags=0}, 120) = 3
bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=3, key=0x1b36a70, value=0x7ffda32551a8, flags=BPF_ANY}, 120) = 0
bpf(BPF_LINK_GET_FD_BY_ID, 0x7ffda32550e0, 120) = -1 ENOENT (No such file or directory)
libbpf: elf: skipping unrecognized data section(7) .eh_frame
libbpf: elf: skipping relo section(12) .rel.eh_frame for section(7) .eh_frame
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=2, insns=0x7ffda3254ff0, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0, prog_name="", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0, func_info_rec_size=0, func_info=NULL, func_info_cnt=0, line_info_rec_size=0, line_info=NULL, line_info_cnt=0, attach_btf_id=0, attach_prog_fd=0}, 120) = 72
bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0D\2\0\0D\2\0\0\356\2\0\0\0\0\0\0\0\0\0\2"..., btf_log_buf=NULL, btf_size=1354, btf_log_size=0, btf_log_level=0}, 120) = 72
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERF_EVENT_ARRAY, key_size=4, value_size=4, max_entries=24, map_flags=BPF_F_PRESERVE_ELEMS, inner_map_fd=0, map_name="events", map_ifindex=0, btf_fd=72, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 105
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERCPU_ARRAY, key_size=4, value_size=24, max_entries=1, map_flags=0, inner_map_fd=0, map_name="prev_readings", map_ifindex=0, btf_fd=72, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 106
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERCPU_ARRAY, key_size=4, value_size=24, max_entries=1, map_flags=0, inner_map_fd=0, map_name="diff_readings", map_ifindex=0, btf_fd=72, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 107
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_RAW_TRACEPOINT, insn_cnt=48, insns=0x1b7fd00, license="Dual BSD/GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(5, 12, 0), prog_flags=0, prog_name="on_switch", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=72, func_info_rec_size=8, func_info=0x1b75a70, func_info_cnt=1, line_info_rec_size=16, line_info=0x1b761b0, line_info_cnt=25, attach_btf_id=0, attach_prog_fd=0}, 120) = 108
bpf(BPF_RAW_TRACEPOINT_OPEN, {raw_tracepoint={name="sched_switch", prog_fd=108}}, 120) = 109
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=109, info_len=32, info=0x7ffda32551b0}}, 120) = 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=107, info_len=80, info=0x7ffda3255200}}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=3, key=0x1b36a70, value=0x7ffda32551a8, flags=BPF_ANY}, 120) = 0
bpf(BPF_LINK_GET_FD_BY_ID, 0x7ffda32550e0, 120) = 110
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=105, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=105, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=105, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=105, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=105, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=105, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=105, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=105, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=105, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=105, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=105, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=105, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=105, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=105, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=105, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=105, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=105, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=105, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=105, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=105, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=105, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=105, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=105, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=105, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=110, info_len=32, info=0x7ffda32551b0}}, 120) = 0
bpf(BPF_PROG_GET_FD_BY_ID, {prog_id=205, next_id=0, open_flags=0}, 120) = 72
bpf(BPF_MAP_GET_FD_BY_ID, {map_id=215, next_id=0, open_flags=0}, 120) = 105
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=72, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
libbpf: elf: skipping unrecognized data section(8) .eh_frame
libbpf: elf: skipping relo section(13) .rel.eh_frame for section(8) .eh_frame
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=72, info_len=216, info=0x7ffda3254f50}}, 120) = 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=72, info_len=216, info=0x1b72d20}}, 120) = 0
bpf(BPF_BTF_GET_FD_BY_ID, {btf_id=311}, 120) = 106
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=106, info_len=32, info=0x7ffda3255000}}, 120) = 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=105, info_len=80, info=0x7ffda32550f0}}, 120) = 0
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=2, insns=0x7ffda3254ff0, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0, prog_name="", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0, func_info_rec_size=0, func_info=NULL, func_info_cnt=0, line_info_rec_size=0, line_info=NULL, line_info_cnt=0, attach_btf_id=0, attach_prog_fd=0}, 120) = 107
bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0\204\2\0\0\204\2\0\0\250\3\0\0\0\0\0\0\0\0\0\2"..., btf_log_buf=NULL, btf_size=1604, btf_log_size=0, btf_log_level=0}, 120) = 107
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERCPU_ARRAY, key_size=4, value_size=24, max_entries=1, map_flags=0, inner_map_fd=0, map_name="accum_readings", map_ifindex=0, btf_fd=107, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 108
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_HASH, key_size=4, value_size=4, max_entries=1, map_flags=0, inner_map_fd=0, map_name="filter", map_ifindex=0, btf_fd=107, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 109
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_ARRAY, key_size=4, value_size=8, max_entries=1, map_flags=BPF_F_MMAPABLE, inner_map_fd=0, map_name="bperf_fo.bss", map_ifindex=0, btf_fd=107, btf_key_type_id=0, btf_value_type_id=27, btf_vmlinux_value_type_id=0}, 120) = 135
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=135, key=0x7ffda3254e50, value=0x7f0a61b6d000, flags=BPF_ANY}, 120) = 0
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_TRACING, insn_cnt=58, insns=0x1b35650, license="Dual BSD/GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(5, 12, 0), prog_flags=0, prog_name="fexit_XXX", prog_ifindex=0, expected_attach_type=BPF_TRACE_FEXIT, prog_btf_fd=107, func_info_rec_size=8, func_info=0x1b7b310, func_info_cnt=1, line_info_rec_size=16, line_info=0x1b7b740, line_info_cnt=28, attach_btf_id=22, attach_prog_fd=72}, 120) = 136
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=109, key=0x7ffda32551b0, value=0x7ffda32551a4, flags=BPF_ANY}, 120) = 0
bpf(BPF_RAW_TRACEPOINT_OPEN, {raw_tracepoint={name=NULL, prog_fd=136}}, 120) = 137
bpf(BPF_OBJ_GET, {pathname="/sys/fs/bpf/perf_attr_map", bpf_fd=0, file_flags=0}, 120) = 3
bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=3, key=0x1b3da70, value=0x7ffda32551a8, flags=BPF_ANY}, 120) = 0
bpf(BPF_LINK_GET_FD_BY_ID, 0x7ffda32550e0, 120) = -1 ENOENT (No such file or directory)
libbpf: elf: skipping unrecognized data section(7) .eh_frame
libbpf: elf: skipping relo section(12) .rel.eh_frame for section(7) .eh_frame
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=2, insns=0x7ffda3254ff0, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0, prog_name="", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0, func_info_rec_size=0, func_info=NULL, func_info_cnt=0, line_info_rec_size=0, line_info=NULL, line_info_cnt=0, attach_btf_id=0, attach_prog_fd=0}, 120) = 105
bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0D\2\0\0D\2\0\0\356\2\0\0\0\0\0\0\0\0\0\2"..., btf_log_buf=NULL, btf_size=1354, btf_log_size=0, btf_log_level=0}, 120) = 105
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERF_EVENT_ARRAY, key_size=4, value_size=4, max_entries=24, map_flags=BPF_F_PRESERVE_ELEMS, inner_map_fd=0, map_name="events", map_ifindex=0, btf_fd=105, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 138
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERCPU_ARRAY, key_size=4, value_size=24, max_entries=1, map_flags=0, inner_map_fd=0, map_name="prev_readings", map_ifindex=0, btf_fd=105, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 139
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERCPU_ARRAY, key_size=4, value_size=24, max_entries=1, map_flags=0, inner_map_fd=0, map_name="diff_readings", map_ifindex=0, btf_fd=105, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 140
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_RAW_TRACEPOINT, insn_cnt=48, insns=0x1b7fd00, license="Dual BSD/GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(5, 12, 0), prog_flags=0, prog_name="on_switch", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=105, func_info_rec_size=8, func_info=0x1b7a670, func_info_cnt=1, line_info_rec_size=16, line_info=0x1b761b0, line_info_cnt=25, attach_btf_id=0, attach_prog_fd=0}, 120) = 141
bpf(BPF_RAW_TRACEPOINT_OPEN, {raw_tracepoint={name="sched_switch", prog_fd=141}}, 120) = 142
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=142, info_len=32, info=0x7ffda32551b0}}, 120) = 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=140, info_len=80, info=0x7ffda3255200}}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=3, key=0x1b3da70, value=0x7ffda32551a8, flags=BPF_ANY}, 120) = 0
bpf(BPF_LINK_GET_FD_BY_ID, 0x7ffda32550e0, 120) = 143
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=138, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=138, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=138, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=138, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=138, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=138, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=138, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=138, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=138, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=138, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=138, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=138, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=138, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=138, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=138, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=138, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=138, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=138, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=138, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=138, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=138, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=138, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=138, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=138, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=143, info_len=32, info=0x7ffda32551b0}}, 120) = 0
bpf(BPF_PROG_GET_FD_BY_ID, {prog_id=209, next_id=0, open_flags=0}, 120) = 105
bpf(BPF_MAP_GET_FD_BY_ID, {map_id=221, next_id=0, open_flags=0}, 120) = 138
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=105, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
libbpf: elf: skipping unrecognized data section(8) .eh_frame
libbpf: elf: skipping relo section(13) .rel.eh_frame for section(8) .eh_frame
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=105, info_len=216, info=0x7ffda3254f50}}, 120) = 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=105, info_len=216, info=0x1b72d20}}, 120) = 0
bpf(BPF_BTF_GET_FD_BY_ID, {btf_id=313}, 120) = 139
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=139, info_len=32, info=0x7ffda3255000}}, 120) = 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=138, info_len=80, info=0x7ffda32550f0}}, 120) = 0
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=2, insns=0x7ffda3254ff0, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0, prog_name="", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0, func_info_rec_size=0, func_info=NULL, func_info_cnt=0, line_info_rec_size=0, line_info=NULL, line_info_cnt=0, attach_btf_id=0, attach_prog_fd=0}, 120) = 140
bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0\204\2\0\0\204\2\0\0\250\3\0\0\0\0\0\0\0\0\0\2"..., btf_log_buf=NULL, btf_size=1604, btf_log_size=0, btf_log_level=0}, 120) = 140
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERCPU_ARRAY, key_size=4, value_size=24, max_entries=1, map_flags=0, inner_map_fd=0, map_name="accum_readings", map_ifindex=0, btf_fd=140, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 141
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_HASH, key_size=4, value_size=4, max_entries=1, map_flags=0, inner_map_fd=0, map_name="filter", map_ifindex=0, btf_fd=140, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 142
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_ARRAY, key_size=4, value_size=8, max_entries=1, map_flags=BPF_F_MMAPABLE, inner_map_fd=0, map_name="bperf_fo.bss", map_ifindex=0, btf_fd=140, btf_key_type_id=0, btf_value_type_id=27, btf_vmlinux_value_type_id=0}, 120) = 168
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=168, key=0x7ffda3254e50, value=0x7f0a61b6c000, flags=BPF_ANY}, 120) = 0
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_TRACING, insn_cnt=58, insns=0x1b35650, license="Dual BSD/GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(5, 12, 0), prog_flags=0, prog_name="fexit_XXX", prog_ifindex=0, expected_attach_type=BPF_TRACE_FEXIT, prog_btf_fd=140, func_info_rec_size=8, func_info=0x1b3ec60, func_info_cnt=1, line_info_rec_size=16, line_info=0x1b3dd00, line_info_cnt=28, attach_btf_id=22, attach_prog_fd=105}, 120) = 169
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=142, key=0x7ffda32551b0, value=0x7ffda32551a4, flags=BPF_ANY}, 120) = 0
bpf(BPF_RAW_TRACEPOINT_OPEN, {raw_tracepoint={name=NULL, prog_fd=169}}, 120) = 170
bpf(BPF_OBJ_GET, {pathname="/sys/fs/bpf/perf_attr_map", bpf_fd=0, file_flags=0}, 120) = 3
bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=3, key=0x1b7ee10, value=0x7ffda32551a8, flags=BPF_ANY}, 120) = 0
bpf(BPF_LINK_GET_FD_BY_ID, 0x7ffda32550e0, 120) = -1 ENOENT (No such file or directory)
libbpf: elf: skipping unrecognized data section(7) .eh_frame
libbpf: elf: skipping relo section(12) .rel.eh_frame for section(7) .eh_frame
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=2, insns=0x7ffda3254ff0, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0, prog_name="", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0, func_info_rec_size=0, func_info=NULL, func_info_cnt=0, line_info_rec_size=0, line_info=NULL, line_info_cnt=0, attach_btf_id=0, attach_prog_fd=0}, 120) = 138
bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0D\2\0\0D\2\0\0\356\2\0\0\0\0\0\0\0\0\0\2"..., btf_log_buf=NULL, btf_size=1354, btf_log_size=0, btf_log_level=0}, 120) = 138
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERF_EVENT_ARRAY, key_size=4, value_size=4, max_entries=24, map_flags=BPF_F_PRESERVE_ELEMS, inner_map_fd=0, map_name="events", map_ifindex=0, btf_fd=138, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 171
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERCPU_ARRAY, key_size=4, value_size=24, max_entries=1, map_flags=0, inner_map_fd=0, map_name="prev_readings", map_ifindex=0, btf_fd=138, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 172
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERCPU_ARRAY, key_size=4, value_size=24, max_entries=1, map_flags=0, inner_map_fd=0, map_name="diff_readings", map_ifindex=0, btf_fd=138, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 173
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_RAW_TRACEPOINT, insn_cnt=48, insns=0x1b7fd00, license="Dual BSD/GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(5, 12, 0), prog_flags=0, prog_name="on_switch", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=138, func_info_rec_size=8, func_info=0x1b7a850, func_info_cnt=1, line_info_rec_size=16, line_info=0x1b761b0, line_info_cnt=25, attach_btf_id=0, attach_prog_fd=0}, 120) = 174
bpf(BPF_RAW_TRACEPOINT_OPEN, {raw_tracepoint={name="sched_switch", prog_fd=174}}, 120) = 175
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=175, info_len=32, info=0x7ffda32551b0}}, 120) = 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=173, info_len=80, info=0x7ffda3255200}}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=3, key=0x1b7ee10, value=0x7ffda32551a8, flags=BPF_ANY}, 120) = 0
bpf(BPF_LINK_GET_FD_BY_ID, 0x7ffda32550e0, 120) = 176
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=171, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=171, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=171, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=171, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=171, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=171, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=171, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=171, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=171, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=171, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=171, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=171, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=171, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=171, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=171, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=171, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=171, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=171, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=171, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=171, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=171, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=171, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=171, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=171, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=176, info_len=32, info=0x7ffda32551b0}}, 120) = 0
bpf(BPF_PROG_GET_FD_BY_ID, {prog_id=213, next_id=0, open_flags=0}, 120) = 138
bpf(BPF_MAP_GET_FD_BY_ID, {map_id=227, next_id=0, open_flags=0}, 120) = 171
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=138, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
libbpf: elf: skipping unrecognized data section(8) .eh_frame
libbpf: elf: skipping relo section(13) .rel.eh_frame for section(8) .eh_frame
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=138, info_len=216, info=0x7ffda3254f50}}, 120) = 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=138, info_len=216, info=0x1b72d20}}, 120) = 0
bpf(BPF_BTF_GET_FD_BY_ID, {btf_id=315}, 120) = 172
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=172, info_len=32, info=0x7ffda3255000}}, 120) = 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=171, info_len=80, info=0x7ffda32550f0}}, 120) = 0
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=2, insns=0x7ffda3254ff0, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0, prog_name="", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0, func_info_rec_size=0, func_info=NULL, func_info_cnt=0, line_info_rec_size=0, line_info=NULL, line_info_cnt=0, attach_btf_id=0, attach_prog_fd=0}, 120) = 173
bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0\204\2\0\0\204\2\0\0\250\3\0\0\0\0\0\0\0\0\0\2"..., btf_log_buf=NULL, btf_size=1604, btf_log_size=0, btf_log_level=0}, 120) = 173
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERCPU_ARRAY, key_size=4, value_size=24, max_entries=1, map_flags=0, inner_map_fd=0, map_name="accum_readings", map_ifindex=0, btf_fd=173, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 174
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_HASH, key_size=4, value_size=4, max_entries=1, map_flags=0, inner_map_fd=0, map_name="filter", map_ifindex=0, btf_fd=173, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 175
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_ARRAY, key_size=4, value_size=8, max_entries=1, map_flags=BPF_F_MMAPABLE, inner_map_fd=0, map_name="bperf_fo.bss", map_ifindex=0, btf_fd=173, btf_key_type_id=0, btf_value_type_id=27, btf_vmlinux_value_type_id=0}, 120) = 201
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=201, key=0x7ffda3254e50, value=0x7f0a61b6b000, flags=BPF_ANY}, 120) = 0
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_TRACING, insn_cnt=58, insns=0x1b35650, license="Dual BSD/GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(5, 12, 0), prog_flags=0, prog_name="fexit_XXX", prog_ifindex=0, expected_attach_type=BPF_TRACE_FEXIT, prog_btf_fd=173, func_info_rec_size=8, func_info=0x1b3fc70, func_info_cnt=1, line_info_rec_size=16, line_info=0x1b3e4c0, line_info_cnt=28, attach_btf_id=22, attach_prog_fd=138}, 120) = 202
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=175, key=0x7ffda32551b0, value=0x7ffda32551a4, flags=BPF_ANY}, 120) = 0
bpf(BPF_RAW_TRACEPOINT_OPEN, {raw_tracepoint={name=NULL, prog_fd=202}}, 120) = 203
bpf(BPF_OBJ_GET, {pathname="/sys/fs/bpf/perf_attr_map", bpf_fd=0, file_flags=0}, 120) = 3
bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=3, key=0x1b7f0f0, value=0x7ffda32551a8, flags=BPF_ANY}, 120) = 0
bpf(BPF_LINK_GET_FD_BY_ID, 0x7ffda32550e0, 120) = -1 ENOENT (No such file or directory)
libbpf: elf: skipping unrecognized data section(7) .eh_frame
libbpf: elf: skipping relo section(12) .rel.eh_frame for section(7) .eh_frame
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=2, insns=0x7ffda3254ff0, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0, prog_name="", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0, func_info_rec_size=0, func_info=NULL, func_info_cnt=0, line_info_rec_size=0, line_info=NULL, line_info_cnt=0, attach_btf_id=0, attach_prog_fd=0}, 120) = 171
bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0D\2\0\0D\2\0\0\356\2\0\0\0\0\0\0\0\0\0\2"..., btf_log_buf=NULL, btf_size=1354, btf_log_size=0, btf_log_level=0}, 120) = 171
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERF_EVENT_ARRAY, key_size=4, value_size=4, max_entries=24, map_flags=BPF_F_PRESERVE_ELEMS, inner_map_fd=0, map_name="events", map_ifindex=0, btf_fd=171, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 204
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERCPU_ARRAY, key_size=4, value_size=24, max_entries=1, map_flags=0, inner_map_fd=0, map_name="prev_readings", map_ifindex=0, btf_fd=171, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 205
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERCPU_ARRAY, key_size=4, value_size=24, max_entries=1, map_flags=0, inner_map_fd=0, map_name="diff_readings", map_ifindex=0, btf_fd=171, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 206
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_RAW_TRACEPOINT, insn_cnt=48, insns=0x1b7fd00, license="Dual BSD/GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(5, 12, 0), prog_flags=0, prog_name="on_switch", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=171, func_info_rec_size=8, func_info=0x1b3e990, func_info_cnt=1, line_info_rec_size=16, line_info=0x1b761b0, line_info_cnt=25, attach_btf_id=0, attach_prog_fd=0}, 120) = 207
bpf(BPF_RAW_TRACEPOINT_OPEN, {raw_tracepoint={name="sched_switch", prog_fd=207}}, 120) = 208
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=208, info_len=32, info=0x7ffda32551b0}}, 120) = 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=206, info_len=80, info=0x7ffda3255200}}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=3, key=0x1b7f0f0, value=0x7ffda32551a8, flags=BPF_ANY}, 120) = 0
bpf(BPF_LINK_GET_FD_BY_ID, 0x7ffda32550e0, 120) = 209
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=204, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=204, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=204, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=204, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=204, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=204, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=204, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=204, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=204, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=204, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=204, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=204, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=204, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=204, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=204, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=204, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=204, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=204, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=204, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=204, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=204, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=204, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=204, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=204, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=209, info_len=32, info=0x7ffda32551b0}}, 120) = 0
bpf(BPF_PROG_GET_FD_BY_ID, {prog_id=217, next_id=0, open_flags=0}, 120) = 171
bpf(BPF_MAP_GET_FD_BY_ID, {map_id=233, next_id=0, open_flags=0}, 120) = 204
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=171, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
libbpf: elf: skipping unrecognized data section(8) .eh_frame
libbpf: elf: skipping relo section(13) .rel.eh_frame for section(8) .eh_frame
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=171, info_len=216, info=0x7ffda3254f50}}, 120) = 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=171, info_len=216, info=0x1b72d20}}, 120) = 0
bpf(BPF_BTF_GET_FD_BY_ID, {btf_id=317}, 120) = 205
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=205, info_len=32, info=0x7ffda3255000}}, 120) = 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=204, info_len=80, info=0x7ffda32550f0}}, 120) = 0
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=2, insns=0x7ffda3254ff0, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0, prog_name="", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0, func_info_rec_size=0, func_info=NULL, func_info_cnt=0, line_info_rec_size=0, line_info=NULL, line_info_cnt=0, attach_btf_id=0, attach_prog_fd=0}, 120) = 206
bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0\204\2\0\0\204\2\0\0\250\3\0\0\0\0\0\0\0\0\0\2"..., btf_log_buf=NULL, btf_size=1604, btf_log_size=0, btf_log_level=0}, 120) = 206
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERCPU_ARRAY, key_size=4, value_size=24, max_entries=1, map_flags=0, inner_map_fd=0, map_name="accum_readings", map_ifindex=0, btf_fd=206, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 207
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_HASH, key_size=4, value_size=4, max_entries=1, map_flags=0, inner_map_fd=0, map_name="filter", map_ifindex=0, btf_fd=206, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 208
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_ARRAY, key_size=4, value_size=8, max_entries=1, map_flags=BPF_F_MMAPABLE, inner_map_fd=0, map_name="bperf_fo.bss", map_ifindex=0, btf_fd=206, btf_key_type_id=0, btf_value_type_id=27, btf_vmlinux_value_type_id=0}, 120) = 234
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=234, key=0x7ffda3254e50, value=0x7f0a61b6a000, flags=BPF_ANY}, 120) = 0
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_TRACING, insn_cnt=58, insns=0x1b35650, license="Dual BSD/GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(5, 12, 0), prog_flags=0, prog_name="fexit_XXX", prog_ifindex=0, expected_attach_type=BPF_TRACE_FEXIT, prog_btf_fd=206, func_info_rec_size=8, func_info=0x1b3f8c0, func_info_cnt=1, line_info_rec_size=16, line_info=0x1b3fd40, line_info_cnt=28, attach_btf_id=22, attach_prog_fd=171}, 120) = 235
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=208, key=0x7ffda32551b0, value=0x7ffda32551a4, flags=BPF_ANY}, 120) = 0
bpf(BPF_RAW_TRACEPOINT_OPEN, {raw_tracepoint={name=NULL, prog_fd=235}}, 120) = 236
bpf(BPF_OBJ_GET, {pathname="/sys/fs/bpf/perf_attr_map", bpf_fd=0, file_flags=0}, 120) = 3
bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=3, key=0x1b7f3b0, value=0x7ffda32551a8, flags=BPF_ANY}, 120) = 0
bpf(BPF_LINK_GET_FD_BY_ID, 0x7ffda32550e0, 120) = -1 ENOENT (No such file or directory)
libbpf: elf: skipping unrecognized data section(7) .eh_frame
libbpf: elf: skipping relo section(12) .rel.eh_frame for section(7) .eh_frame
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=2, insns=0x7ffda3254ff0, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0, prog_name="", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0, func_info_rec_size=0, func_info=NULL, func_info_cnt=0, line_info_rec_size=0, line_info=NULL, line_info_cnt=0, attach_btf_id=0, attach_prog_fd=0}, 120) = 204
bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0D\2\0\0D\2\0\0\356\2\0\0\0\0\0\0\0\0\0\2"..., btf_log_buf=NULL, btf_size=1354, btf_log_size=0, btf_log_level=0}, 120) = 204
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERF_EVENT_ARRAY, key_size=4, value_size=4, max_entries=24, map_flags=BPF_F_PRESERVE_ELEMS, inner_map_fd=0, map_name="events", map_ifindex=0, btf_fd=204, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 237
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERCPU_ARRAY, key_size=4, value_size=24, max_entries=1, map_flags=0, inner_map_fd=0, map_name="prev_readings", map_ifindex=0, btf_fd=204, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 238
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERCPU_ARRAY, key_size=4, value_size=24, max_entries=1, map_flags=0, inner_map_fd=0, map_name="diff_readings", map_ifindex=0, btf_fd=204, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 239
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_RAW_TRACEPOINT, insn_cnt=48, insns=0x1b7fd00, license="Dual BSD/GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(5, 12, 0), prog_flags=0, prog_name="on_switch", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=204, func_info_rec_size=8, func_info=0x1b40a20, func_info_cnt=1, line_info_rec_size=16, line_info=0x1b761b0, line_info_cnt=25, attach_btf_id=0, attach_prog_fd=0}, 120) = 240
bpf(BPF_RAW_TRACEPOINT_OPEN, {raw_tracepoint={name="sched_switch", prog_fd=240}}, 120) = 241
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=241, info_len=32, info=0x7ffda32551b0}}, 120) = 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=239, info_len=80, info=0x7ffda3255200}}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=3, key=0x1b7f3b0, value=0x7ffda32551a8, flags=BPF_ANY}, 120) = 0
bpf(BPF_LINK_GET_FD_BY_ID, 0x7ffda32550e0, 120) = 242
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=237, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=237, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=237, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=237, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=237, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=237, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=237, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=237, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=237, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=237, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=237, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=237, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=237, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=237, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=237, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=237, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=237, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=237, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=237, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=237, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=237, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=237, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=237, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=237, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=242, info_len=32, info=0x7ffda32551b0}}, 120) = 0
bpf(BPF_PROG_GET_FD_BY_ID, {prog_id=221, next_id=0, open_flags=0}, 120) = 204
bpf(BPF_MAP_GET_FD_BY_ID, {map_id=239, next_id=0, open_flags=0}, 120) = 237
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=204, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
libbpf: elf: skipping unrecognized data section(8) .eh_frame
libbpf: elf: skipping relo section(13) .rel.eh_frame for section(8) .eh_frame
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=204, info_len=216, info=0x7ffda3254f50}}, 120) = 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=204, info_len=216, info=0x1b72d20}}, 120) = 0
bpf(BPF_BTF_GET_FD_BY_ID, {btf_id=319}, 120) = 238
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=238, info_len=32, info=0x7ffda3255000}}, 120) = 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=237, info_len=80, info=0x7ffda32550f0}}, 120) = 0
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=2, insns=0x7ffda3254ff0, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0, prog_name="", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0, func_info_rec_size=0, func_info=NULL, func_info_cnt=0, line_info_rec_size=0, line_info=NULL, line_info_cnt=0, attach_btf_id=0, attach_prog_fd=0}, 120) = 239
bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0\204\2\0\0\204\2\0\0\250\3\0\0\0\0\0\0\0\0\0\2"..., btf_log_buf=NULL, btf_size=1604, btf_log_size=0, btf_log_level=0}, 120) = 239
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERCPU_ARRAY, key_size=4, value_size=24, max_entries=1, map_flags=0, inner_map_fd=0, map_name="accum_readings", map_ifindex=0, btf_fd=239, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 240
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_HASH, key_size=4, value_size=4, max_entries=1, map_flags=0, inner_map_fd=0, map_name="filter", map_ifindex=0, btf_fd=239, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 241
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_ARRAY, key_size=4, value_size=8, max_entries=1, map_flags=BPF_F_MMAPABLE, inner_map_fd=0, map_name="bperf_fo.bss", map_ifindex=0, btf_fd=239, btf_key_type_id=0, btf_value_type_id=27, btf_vmlinux_value_type_id=0}, 120) = 267
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=267, key=0x7ffda3254e50, value=0x7f0a61b69000, flags=BPF_ANY}, 120) = 0
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_TRACING, insn_cnt=58, insns=0x1b35650, license="Dual BSD/GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(5, 12, 0), prog_flags=0, prog_name="fexit_XXX", prog_ifindex=0, expected_attach_type=BPF_TRACE_FEXIT, prog_btf_fd=239, func_info_rec_size=8, func_info=0x1b421c0, func_info_cnt=1, line_info_rec_size=16, line_info=0x1b41550, line_info_cnt=28, attach_btf_id=22, attach_prog_fd=204}, 120) = 268
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=241, key=0x7ffda32551b0, value=0x7ffda32551a4, flags=BPF_ANY}, 120) = 0
bpf(BPF_RAW_TRACEPOINT_OPEN, {raw_tracepoint={name=NULL, prog_fd=268}}, 120) = 269
bpf(BPF_OBJ_GET, {pathname="/sys/fs/bpf/perf_attr_map", bpf_fd=0, file_flags=0}, 120) = 3
bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=3, key=0x1b7e8c0, value=0x7ffda32551a8, flags=BPF_ANY}, 120) = 0
bpf(BPF_LINK_GET_FD_BY_ID, 0x7ffda32550e0, 120) = -1 ENOENT (No such file or directory)
libbpf: elf: skipping unrecognized data section(7) .eh_frame
libbpf: elf: skipping relo section(12) .rel.eh_frame for section(7) .eh_frame
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=2, insns=0x7ffda3254ff0, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0, prog_name="", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0, func_info_rec_size=0, func_info=NULL, func_info_cnt=0, line_info_rec_size=0, line_info=NULL, line_info_cnt=0, attach_btf_id=0, attach_prog_fd=0}, 120) = 237
bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0D\2\0\0D\2\0\0\356\2\0\0\0\0\0\0\0\0\0\2"..., btf_log_buf=NULL, btf_size=1354, btf_log_size=0, btf_log_level=0}, 120) = 237
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERF_EVENT_ARRAY, key_size=4, value_size=4, max_entries=24, map_flags=BPF_F_PRESERVE_ELEMS, inner_map_fd=0, map_name="events", map_ifindex=0, btf_fd=237, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 270
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERCPU_ARRAY, key_size=4, value_size=24, max_entries=1, map_flags=0, inner_map_fd=0, map_name="prev_readings", map_ifindex=0, btf_fd=237, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 271
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERCPU_ARRAY, key_size=4, value_size=24, max_entries=1, map_flags=0, inner_map_fd=0, map_name="diff_readings", map_ifindex=0, btf_fd=237, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 272
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_RAW_TRACEPOINT, insn_cnt=48, insns=0x1b7fd00, license="Dual BSD/GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(5, 12, 0), prog_flags=0, prog_name="on_switch", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=237, func_info_rec_size=8, func_info=0x1b42200, func_info_cnt=1, line_info_rec_size=16, line_info=0x1b761b0, line_info_cnt=25, attach_btf_id=0, attach_prog_fd=0}, 120) = 273
bpf(BPF_RAW_TRACEPOINT_OPEN, {raw_tracepoint={name="sched_switch", prog_fd=273}}, 120) = 274
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=274, info_len=32, info=0x7ffda32551b0}}, 120) = 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=272, info_len=80, info=0x7ffda3255200}}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=3, key=0x1b7e8c0, value=0x7ffda32551a8, flags=BPF_ANY}, 120) = 0
bpf(BPF_LINK_GET_FD_BY_ID, 0x7ffda32550e0, 120) = 275
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=270, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=270, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=270, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=270, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=270, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=270, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=270, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=270, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=270, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=270, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=270, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=270, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=270, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=270, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=270, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=270, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=270, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=270, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=270, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=270, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=270, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=270, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=270, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=270, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=275, info_len=32, info=0x7ffda32551b0}}, 120) = 0
bpf(BPF_PROG_GET_FD_BY_ID, {prog_id=225, next_id=0, open_flags=0}, 120) = 237
bpf(BPF_MAP_GET_FD_BY_ID, {map_id=245, next_id=0, open_flags=0}, 120) = 270
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=237, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
libbpf: elf: skipping unrecognized data section(8) .eh_frame
libbpf: elf: skipping relo section(13) .rel.eh_frame for section(8) .eh_frame
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=237, info_len=216, info=0x7ffda3254f50}}, 120) = 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=237, info_len=216, info=0x1b72d20}}, 120) = 0
bpf(BPF_BTF_GET_FD_BY_ID, {btf_id=321}, 120) = 271
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=271, info_len=32, info=0x7ffda3255000}}, 120) = 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=270, info_len=80, info=0x7ffda32550f0}}, 120) = 0
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=2, insns=0x7ffda3254ff0, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0, prog_name="", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0, func_info_rec_size=0, func_info=NULL, func_info_cnt=0, line_info_rec_size=0, line_info=NULL, line_info_cnt=0, attach_btf_id=0, attach_prog_fd=0}, 120) = 272
bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0\204\2\0\0\204\2\0\0\250\3\0\0\0\0\0\0\0\0\0\2"..., btf_log_buf=NULL, btf_size=1604, btf_log_size=0, btf_log_level=0}, 120) = 272
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERCPU_ARRAY, key_size=4, value_size=24, max_entries=1, map_flags=0, inner_map_fd=0, map_name="accum_readings", map_ifindex=0, btf_fd=272, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 273
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_HASH, key_size=4, value_size=4, max_entries=1, map_flags=0, inner_map_fd=0, map_name="filter", map_ifindex=0, btf_fd=272, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 274
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_ARRAY, key_size=4, value_size=8, max_entries=1, map_flags=BPF_F_MMAPABLE, inner_map_fd=0, map_name="bperf_fo.bss", map_ifindex=0, btf_fd=272, btf_key_type_id=0, btf_value_type_id=27, btf_vmlinux_value_type_id=0}, 120) = 300
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=300, key=0x7ffda3254e50, value=0x7f0a61b68000, flags=BPF_ANY}, 120) = 0
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_TRACING, insn_cnt=58, insns=0x1b35650, license="Dual BSD/GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(5, 12, 0), prog_flags=0, prog_name="fexit_XXX", prog_ifindex=0, expected_attach_type=BPF_TRACE_FEXIT, prog_btf_fd=272, func_info_rec_size=8, func_info=0x1b43810, func_info_cnt=1, line_info_rec_size=16, line_info=0x1b42300, line_info_cnt=28, attach_btf_id=22, attach_prog_fd=237}, 120) = 301
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=274, key=0x7ffda32551b0, value=0x7ffda32551a4, flags=BPF_ANY}, 120) = 0
bpf(BPF_RAW_TRACEPOINT_OPEN, {raw_tracepoint={name=NULL, prog_fd=301}}, 120) = 302
bpf(BPF_OBJ_GET, {pathname="/sys/fs/bpf/perf_attr_map", bpf_fd=0, file_flags=0}, 120) = 3
bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=3, key=0x1b76d00, value=0x7ffda32551a8, flags=BPF_ANY}, 120) = 0
bpf(BPF_LINK_GET_FD_BY_ID, 0x7ffda32550e0, 120) = -1 ENOENT (No such file or directory)
libbpf: elf: skipping unrecognized data section(7) .eh_frame
libbpf: elf: skipping relo section(12) .rel.eh_frame for section(7) .eh_frame
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=2, insns=0x7ffda3254ff0, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0, prog_name="", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0, func_info_rec_size=0, func_info=NULL, func_info_cnt=0, line_info_rec_size=0, line_info=NULL, line_info_cnt=0, attach_btf_id=0, attach_prog_fd=0}, 120) = 270
bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0D\2\0\0D\2\0\0\356\2\0\0\0\0\0\0\0\0\0\2"..., btf_log_buf=NULL, btf_size=1354, btf_log_size=0, btf_log_level=0}, 120) = 270
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERF_EVENT_ARRAY, key_size=4, value_size=4, max_entries=24, map_flags=BPF_F_PRESERVE_ELEMS, inner_map_fd=0, map_name="events", map_ifindex=0, btf_fd=270, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 303
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERCPU_ARRAY, key_size=4, value_size=24, max_entries=1, map_flags=0, inner_map_fd=0, map_name="prev_readings", map_ifindex=0, btf_fd=270, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 304
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERCPU_ARRAY, key_size=4, value_size=24, max_entries=1, map_flags=0, inner_map_fd=0, map_name="diff_readings", map_ifindex=0, btf_fd=270, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 305
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_RAW_TRACEPOINT, insn_cnt=48, insns=0x1b7fd00, license="Dual BSD/GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(5, 12, 0), prog_flags=0, prog_name="on_switch", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=270, func_info_rec_size=8, func_info=0x1b451b0, func_info_cnt=1, line_info_rec_size=16, line_info=0x1b761b0, line_info_cnt=25, attach_btf_id=0, attach_prog_fd=0}, 120) = 306
bpf(BPF_RAW_TRACEPOINT_OPEN, {raw_tracepoint={name="sched_switch", prog_fd=306}}, 120) = 307
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=307, info_len=32, info=0x7ffda32551b0}}, 120) = 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=305, info_len=80, info=0x7ffda3255200}}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=3, key=0x1b76d00, value=0x7ffda32551a8, flags=BPF_ANY}, 120) = 0
bpf(BPF_LINK_GET_FD_BY_ID, 0x7ffda32550e0, 120) = 308
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=303, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=303, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=303, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=303, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=303, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=303, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=303, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=303, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=303, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=303, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=303, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=303, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=303, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=303, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=303, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=303, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=303, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=303, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=303, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=303, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=303, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=303, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=303, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=303, key=0x7ffda325505c, value=0x7ffda3255058, flags=BPF_ANY}, 120) = 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=308, info_len=32, info=0x7ffda32551b0}}, 120) = 0
bpf(BPF_PROG_GET_FD_BY_ID, {prog_id=229, next_id=0, open_flags=0}, 120) = 270
bpf(BPF_MAP_GET_FD_BY_ID, {map_id=251, next_id=0, open_flags=0}, 120) = 303
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=270, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
libbpf: elf: skipping unrecognized data section(8) .eh_frame
libbpf: elf: skipping relo section(13) .rel.eh_frame for section(8) .eh_frame
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=270, info_len=216, info=0x7ffda3254f50}}, 120) = 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=270, info_len=216, info=0x1b72d20}}, 120) = 0
bpf(BPF_BTF_GET_FD_BY_ID, {btf_id=323}, 120) = 304
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=304, info_len=32, info=0x7ffda3255000}}, 120) = 0
bpf(BPF_OBJ_GET_INFO_BY_FD, {info={bpf_fd=303, info_len=80, info=0x7ffda32550f0}}, 120) = 0
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_SOCKET_FILTER, insn_cnt=2, insns=0x7ffda3254ff0, license="GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(0, 0, 0), prog_flags=0, prog_name="", prog_ifindex=0, expected_attach_type=BPF_CGROUP_INET_INGRESS, prog_btf_fd=0, func_info_rec_size=0, func_info=NULL, func_info_cnt=0, line_info_rec_size=0, line_info=NULL, line_info_cnt=0, attach_btf_id=0, attach_prog_fd=0}, 120) = 305
bpf(BPF_BTF_LOAD, {btf="\237\353\1\0\30\0\0\0\0\0\0\0\204\2\0\0\204\2\0\0\250\3\0\0\0\0\0\0\0\0\0\2"..., btf_log_buf=NULL, btf_size=1604, btf_log_size=0, btf_log_level=0}, 120) = 305
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_PERCPU_ARRAY, key_size=4, value_size=24, max_entries=1, map_flags=0, inner_map_fd=0, map_name="accum_readings", map_ifindex=0, btf_fd=305, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 306
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_HASH, key_size=4, value_size=4, max_entries=1, map_flags=0, inner_map_fd=0, map_name="filter", map_ifindex=0, btf_fd=305, btf_key_type_id=0, btf_value_type_id=0, btf_vmlinux_value_type_id=0}, 120) = 307
bpf(BPF_MAP_CREATE, {map_type=BPF_MAP_TYPE_ARRAY, key_size=4, value_size=8, max_entries=1, map_flags=BPF_F_MMAPABLE, inner_map_fd=0, map_name="bperf_fo.bss", map_ifindex=0, btf_fd=305, btf_key_type_id=0, btf_value_type_id=27, btf_vmlinux_value_type_id=0}, 120) = 333
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=333, key=0x7ffda3254e50, value=0x7f0a61b67000, flags=BPF_ANY}, 120) = 0
bpf(BPF_PROG_LOAD, {prog_type=BPF_PROG_TYPE_TRACING, insn_cnt=58, insns=0x1b35650, license="Dual BSD/GPL", log_level=0, log_size=0, log_buf=NULL, kern_version=KERNEL_VERSION(5, 12, 0), prog_flags=0, prog_name="fexit_XXX", prog_ifindex=0, expected_attach_type=BPF_TRACE_FEXIT, prog_btf_fd=305, func_info_rec_size=8, func_info=0x1b45120, func_info_cnt=1, line_info_rec_size=16, line_info=0x1b44100, line_info_cnt=28, attach_btf_id=22, attach_prog_fd=270}, 120) = 334
bpf(BPF_MAP_UPDATE_ELEM, {map_fd=307, key=0x7ffda32551b0, value=0x7ffda32551a4, flags=BPF_ANY}, 120) = 0
bpf(BPF_RAW_TRACEPOINT_OPEN, {raw_tracepoint={name=NULL, prog_fd=334}}, 120) = 335
--- SIGCHLD {si_signo=SIGCHLD, si_code=CLD_EXITED, si_pid=75357, si_uid=0, si_status=0, si_utime=0, si_stime=0} ---
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=4, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=4, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=4, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=4, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=4, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=4, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=4, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=4, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=4, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=4, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=4, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=4, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=4, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=4, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=4, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=4, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=4, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=4, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=4, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=4, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=4, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=4, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=4, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=4, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=9, key=0x7ffda3255160, value=0x7ffda3254f10, flags=BPF_ANY}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=5, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=5, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=5, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=5, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=5, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=5, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=5, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=5, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=5, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=5, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=5, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=5, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=5, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=5, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=5, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=5, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=5, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=5, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=5, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=5, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=5, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=5, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=5, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=5, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=42, key=0x7ffda3255160, value=0x7ffda3254f10, flags=BPF_ANY}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=39, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=39, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=39, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=39, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=39, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=39, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=39, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=39, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=39, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=39, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=39, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=39, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=39, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=39, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=39, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=39, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=39, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=39, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=39, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=39, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=39, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=39, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=39, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=39, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=75, key=0x7ffda3255160, value=0x7ffda3254f10, flags=BPF_ANY}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=72, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=72, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=72, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=72, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=72, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=72, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=72, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=72, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=72, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=72, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=72, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=72, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=72, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=72, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=72, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=72, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=72, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=72, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=72, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=72, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=72, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=72, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=72, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=72, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=108, key=0x7ffda3255160, value=0x7ffda3254f10, flags=BPF_ANY}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=105, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=105, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=105, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=105, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=105, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=105, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=105, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=105, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=105, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=105, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=105, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=105, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=105, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=105, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=105, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=105, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=105, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=105, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=105, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=105, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=105, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=105, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=105, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=105, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=141, key=0x7ffda3255160, value=0x7ffda3254f10, flags=BPF_ANY}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=138, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=138, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=138, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=138, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=138, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=138, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=138, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=138, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=138, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=138, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=138, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=138, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=138, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=138, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=138, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=138, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=138, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=138, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=138, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=138, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=138, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=138, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=138, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=138, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=174, key=0x7ffda3255160, value=0x7ffda3254f10, flags=BPF_ANY}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=171, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=171, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=171, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=171, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=171, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=171, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=171, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=171, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=171, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=171, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=171, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=171, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=171, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=171, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=171, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=171, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=171, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=171, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=171, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=171, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=171, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=171, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=171, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=171, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=207, key=0x7ffda3255160, value=0x7ffda3254f10, flags=BPF_ANY}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=204, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=204, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=204, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=204, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=204, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=204, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=204, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=204, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=204, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=204, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=204, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=204, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=204, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=204, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=204, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=204, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=204, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=204, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=204, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=204, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=204, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=204, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=204, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=204, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=240, key=0x7ffda3255160, value=0x7ffda3254f10, flags=BPF_ANY}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=237, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=237, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=237, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=237, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=237, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=237, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=237, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=237, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=237, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=237, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=237, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=237, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=237, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=237, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=237, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=237, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=237, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=237, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=237, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=237, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=237, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=237, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=237, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=237, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=273, key=0x7ffda3255160, value=0x7ffda3254f10, flags=BPF_ANY}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=270, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=270, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=270, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=270, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=270, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=270, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=270, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=270, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=270, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=270, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=270, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=270, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=270, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=270, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=270, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=270, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=270, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=270, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=270, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=270, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=270, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=270, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=270, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_PROG_TEST_RUN, {test={prog_fd=270, retval=0, data_size_in=0, data_size_out=0, data_in=NULL, data_out=NULL, repeat=0, duration=0, ctx_size_in=0, ctx_size_out=0, ctx_in=NULL, ctx_out=NULL}, ...}, 120) = 0
bpf(BPF_MAP_LOOKUP_ELEM, {map_fd=306, key=0x7ffda3255160, value=0x7ffda3254f10, flags=BPF_ANY}, 120) = 0

 Performance counter stats for 'sleep 1':

              1.64 msec task-clock                #    0.002 CPUs utilized          
                 3      context-switches          #    1.827 K/sec                  
                 1      cpu-migrations            #  609.091 /sec                   
                69      page-faults               #   42.027 K/sec                  
         6,661,659      cycles                    #    4.058 GHz                    
         2,098,928      stalled-cycles-frontend   #   31.51% frontend cycles idle     (88.25%)
           354,763      stalled-cycles-backend    #    5.33% backend cycles idle      (87.59%)
         2,741,209      instructions              #    0.41  insn per cycle         
                                                  #    0.77  stalled cycles per insn  (43.20%)
           463,473      branches                  #  282.297 M/sec                    (80.93%)
            13,458      branch-misses             #    2.90% of all branches        

       1.001882586 seconds time elapsed

       0.000000000 seconds user
       0.001667000 seconds sys


--- SIGCHLD {si_signo=SIGCHLD, si_code=SI_USER, si_pid=75348, si_uid=0} ---
+++ exited with 0 +++
[root@five pahole]# 


