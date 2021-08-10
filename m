Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E78823E843E
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 22:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233139AbhHJUWL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 16:22:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:37896 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233077AbhHJUWF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 16:22:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id CF3C860F94;
        Tue, 10 Aug 2021 20:21:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1628626903;
        bh=YTnQFep4RkFcTkX+vvuBa3blCqAyL5fTKmeyY7TAd3w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Rrq0y0vznqVVAe4zJTyXgaCRHt8uDdfbVTdLWX0RJC1oYXlFmPyPH0Ml5zPsOyJiJ
         TQ/n5gQMZRqVCx5v9aSdJW4ScKEUuExoenecNORW/dajLee4hGavCjth/62qo8JUHB
         clv7rIyDXw+2lp8NkqCuJjwwyzXj2PosKbE9RSwiqIJoHHSoGT4ldxhnf2PEKHC2sh
         wrKz/+AaLeryKvUeWDS1ILseMrLEl9TaqxgewAY5gCIbndz6U3Q7nD3Yv1xUpFhs/T
         08dYGsVVW8uWNRG5dUjWAIoo3dcb2X0OT3+P8aQUa5CMZgw4GmjFSHXJw1yH5v0SGe
         K/YkTn8HLjVrQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B00F7403F2; Tue, 10 Aug 2021 17:21:39 -0300 (-03)
Date:   Tue, 10 Aug 2021 17:21:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Jiri Olsa <jolsa@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] perf tools: Add dlfilter test
Message-ID: <YRLf0+ij2rNLvdRj@kernel.org>
References: <20210810114813.12951-1-adrian.hunter@intel.com>
 <20210810114813.12951-6-adrian.hunter@intel.com>
 <YRLGTfQdg7pBcf29@kernel.org>
 <e0eba7e7-d9ae-eff4-254c-6fe16809a675@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e0eba7e7-d9ae-eff4-254c-6fe16809a675@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Aug 10, 2021 at 10:06:13PM +0300, Adrian Hunter escreveu:
> On 10/08/21 9:32 pm, Arnaldo Carvalho de Melo wrote:
> > Em Tue, Aug 10, 2021 at 02:48:13PM +0300, Adrian Hunter escreveu:
> >> Add a perf test to test the dlfilter C API.
> >>
> >> A perf.data file is synthesized and then processed by perf script with a
> >> dlfilter named dlfilter-test-api-v0.so. Also a C file is compiled to
> >> provide a dso to match the synthesized perf.data file.
> > 
> > [root@five ~]# perf test dlfilter
> > 72: dlfilter C API                                                  : FAILED!
> > [root@five ~]# perf test -v dlfilter
> > 72: dlfilter C API                                                  :
> > --- start ---
> > test child forked, pid 3358542
> > Checking for gcc
> > Command: gcc --version
> > gcc (GCC) 11.1.1 20210531 (Red Hat 11.1.1-3)
> > Copyright (C) 2021 Free Software Foundation, Inc.
> > This is free software; see the source for copying conditions.  There is NO
> > warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
> > 
> > dlfilters path: /var/home/acme/libexec/perf-core/dlfilters
> > Command: gcc -g -o /tmp/dlfilter-test-3358542-prog /tmp/dlfilter-test-3358542-prog.c
> > Creating new host machine structure
> > Command: /var/home/acme/bin/perf script -i /tmp/dlfilter-test-3358542-perf-data --dlfilter /var/home/acme/libexec/perf-core/dlfilters/dlfilter-test-api-v0.so --dlarg first --dlarg 1 --dlarg 4198669 --dlarg 4198662 --dlarg 0 --dlarg last
> > Failed with return value 139
> > test child finished with -1
> > ---- end ----
> > dlfilter C API: FAILED!
> > [root@five ~]# cat /etc/redhat-release
> > Fedora release 34 (Thirty Four)
> > [root@five ~]# cat /etc/os-release
> > NAME=Fedora
> > VERSION="34.20210721.0 (Silverblue)"
> > ID=fedora
> > VERSION_ID=34
> > VERSION_CODENAME=""
> > PLATFORM_ID="platform:f34"
> > PRETTY_NAME="Fedora 34.20210721.0 (Silverblue)"
> > ANSI_COLOR="0;38;2;60;110;180"
> > LOGO=fedora-logo-icon
> > CPE_NAME="cpe:/o:fedoraproject:fedora:34"
> > HOME_URL="https://fedoraproject.org/"
> > DOCUMENTATION_URL="https://docs.fedoraproject.org/en-US/fedora-silverblue/"
> > SUPPORT_URL="https://fedoraproject.org/wiki/Communicating_and_getting_help"
> > BUG_REPORT_URL="https://bugzilla.redhat.com/"
> > REDHAT_BUGZILLA_PRODUCT="Fedora"
> > REDHAT_BUGZILLA_PRODUCT_VERSION=34
> > REDHAT_SUPPORT_PRODUCT="Fedora"
> > REDHAT_SUPPORT_PRODUCT_VERSION=34
> > PRIVACY_POLICY_URL="https://fedoraproject.org/wiki/Legal:PrivacyPolicy"
> > VARIANT="Silverblue"
> > VARIANT_ID=silverblue
> > OSTREE_VERSION='34.20210721.0'
> > [root@five ~]#
> > 
> > Trying to figure this out...
> 
> What does it give with two 'v''s ?
> i.e.
> 
> perf test -vv dlfilter

What I've tried so far:

[root@five ~]# perf probe -x /var/home/acme/libexec/perf-core/dlfilters/dlfilter-test-api-v0.so -F
called.0
called.5
check_addr_al
check_al
check_attr
check_sample
completed.0
deregister_tm_clones
do_checks
filt_dat
filter_description
filter_description
filter_event
filter_event
filter_event_early
filter_event_early
frame_dummy
perf_dlfilter_fns
perf_dlfilter_fns
register_tm_clones
start
start
stop
stop
test_fail
verbose
[root@five ~]# perf probe -l
  probe_dlfilter:check_addr_al (on check_addr_al in /var/home/acme/libexec/perf-core/dlfilters/dlfilter-test-api-v0.so)
  probe_dlfilter:check_al (on check_al in /var/home/acme/libexec/perf-core/dlfilters/dlfilter-test-api-v0.so)
  probe_dlfilter:check_attr (on check_attr in /var/home/acme/libexec/perf-core/dlfilters/dlfilter-test-api-v0.so)
  probe_dlfilter:check_sample (on check_sample in /var/home/acme/libexec/perf-core/dlfilters/dlfilter-test-api-v0.so)
  probe_dlfilter:filter_description (on filter_description in /var/home/acme/libexec/perf-core/dlfilters/dlfilter-test-api-v0.so)
  probe_dlfilter:filter_event (on filter_event in /var/home/acme/libexec/perf-core/dlfilters/dlfilter-test-api-v0.so)
  probe_dlfilter:filter_event_early (on filter_event_early in /var/home/acme/libexec/perf-core/dlfilters/dlfilter-test-api-v0.so)
  probe_dlfilter:start (on start in /var/home/acme/libexec/perf-core/dlfilters/dlfilter-test-api-v0.so)
  probe_dlfilter:stop  (on stop in /var/home/acme/libexec/perf-core/dlfilters/dlfilter-test-api-v0.so)
  probe_dlfilter:test_fail (on test_fail in /var/home/acme/libexec/perf-core/dlfilters/dlfilter-test-api-v0.so)
[root@five ~]# perf trace -e probe_dlfilter:*/max-stack=10/ perf test -v dlfilter
72: dlfilter C API                                                  :
--- start ---
test child forked, pid 3360902
Checking for gcc
Command: gcc --version
gcc (GCC) 11.1.1 20210531 (Red Hat 11.1.1-3)
Copyright (C) 2021 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

dlfilters path: /var/home/acme/libexec/perf-core/dlfilters
Command: gcc -g -o /tmp/dlfilter-test-3360902-prog /tmp/dlfilter-test-3360902-prog.c
     0.000 perf/3360902 probe_dlfilter:filter_description(__probe_ip: 140448631966717)
                                       filter_description (/var/home/acme/libexec/perf-core/dlfilters/dlfilter-test-api-v0.so)
                                       test__dlfilter (/var/home/acme/bin/perf)
                                       test_and_print (/var/home/acme/bin/perf)
                                       cmd_test (/var/home/acme/bin/perf)
                                       run_builtin (/var/home/acme/bin/perf)
                                       main (/var/home/acme/bin/perf)
                                       __libc_start_main (/usr/lib64/libc-2.33.so)
Creating new host machine structure
Command: /var/home/acme/bin/perf script -i /tmp/dlfilter-test-3360902-perf-data --dlfilter /var/home/acme/libexec/perf-core/dlfilters/dlfilter-test-api-v0.so --dlarg first --dlarg 1 --dlarg 4198669 --dlarg 4198662 --dlarg 0 --dlarg last
Failed with return value 139
test child finished with -1
---- end ----
dlfilter C API: FAILED!
[root@five ~]# perf trace -e probe_dlfilter:*/max-stack=10/ perf test -vv dlfilter
72: dlfilter C API                                                  :
--- start ---
test child forked, pid 3360986
Checking for gcc
Command: gcc --version
     0.000 :3360986/3360986 probe_dlfilter:filter_description(__probe_ip: 140709239057405)
                                       filter_description (/var/home/acme/libexec/perf-core/dlfilters/dlfilter-test-api-v0.so)
                                       [0] ([unknown])
                                       [0] ([unknown])
                                       [0] ([unknown])
                                       [0] ([unknown])
                                       [0] ([unknown])
                                       [0] ([unknown])
gcc (GCC) 11.1.1 20210531 (Red Hat 11.1.1-3)
Copyright (C) 2021 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

dlfilters path: /var/home/acme/libexec/perf-core/dlfilters
Command: cat /tmp/dlfilter-test-3360986-prog.c ; echo
int bar(){};int foo(){bar();};int main(){foo();return 0;}
Command: gcc -g -o /tmp/dlfilter-test-3360986-prog /tmp/dlfilter-test-3360986-prog.c
Creating new host machine structure
Command: /var/home/acme/bin/perf script -i /tmp/dlfilter-test-3360986-perf-data -D

0 [0x90]: event: 64
.
. ... raw event: size 144 bytes
.  0000:  40 00 00 00 00 00 90 00 00 00 00 00 80 00 00 00  @...............
.  0010:  04 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
.  0020:  8f 03 01 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
.  0030:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
.  0040:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
.  0050:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
.  0060:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
.  0070:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
.  0080:  00 00 00 00 00 00 00 00 63 00 00 00 00 00 00 00  ........c.......

-1 -1 0 [0x90]: PERF_RECORD_ATTR
0x90 [0x20]: event: 3
.
. ... raw event: size 32 bytes
.  0000:  03 00 00 00 02 00 20 00 39 30 00 00 3a 30 00 00  ...... .90..:0..
.  0010:  74 65 73 74 2d 70 72 6f 67 00 00 00 00 00 00 00  test-prog.......

-1 -1 0x90 [0x20]: PERF_RECORD_COMM: test-prog:12345/12346

0xb0 [0x48]: event: 1
.
. ... raw event: size 72 bytes
.  0000:  01 00 00 00 02 00 48 00 39 30 00 00 3a 30 00 00  ......H.90..:0..
.  0010:  00 00 40 00 00 00 00 00 00 00 01 00 00 00 00 00  ..@.............
.  0020:  00 00 00 00 00 00 00 00 2f 74 6d 70 2f 64 6c 66  ......../tmp/dlf
.  0030:  69 6c 74 65 72 2d 74 65 73 74 2d 33 33 36 30 39  ilter-test-33609
.  0040:  38 36 2d 70 72 6f 67 00                          86-prog.        

-1 -1 0xb0 [0x48]: PERF_RECORD_MMAP 12345/12346: [0x400000(0x10000) @ 0]: x /tmp/dlfilter-test-3360986-prog

0xf8 [0x48]: event: 9
.
. ... raw event: size 72 bytes
.  0000:  09 00 00 00 02 00 48 00 63 00 00 00 00 00 00 00  ......H.c.......
.  0010:  0d 11 40 00 00 00 00 00 39 30 00 00 3a 30 00 00  ..@.....90..:0..
.  0020:  d2 02 96 49 00 00 00 00 06 11 40 00 00 00 00 00  <D2>..I......@.....
.  0030:  65 00 00 00 00 00 00 00 1f 00 00 00 00 00 00 00  e...............
.  0040:  39 c3 60 20 00 00 00 00                          9<C3>` ....        

31 1234567890 0xf8 [0x48]: PERF_RECORD_SAMPLE(IP, 0x2): 12345/12346: 0x40110d period: 543212345 addr: 0x401106
 ... thread: test-prog:12346
 ...... dso: /tmp/dlfilter-test-3360986-prog
       test-prog 12346 [031]     1.234567:  543212345 branches:HG:            40110d foo+0x0 (/tmp/dlfilter-test-3360986-prog) =>           401106 bar+0x0 (/tmp/dlfilter-test-3360986-prog)
Command: /var/home/acme/bin/perf script -i /tmp/dlfilter-test-3360986-perf-data --dlfilter /var/home/acme/libexec/perf-core/dlfilters/dlfilter-test-api-v0.so --dlarg first --dlarg 2 --dlarg 4198669 --dlarg 4198662 --dlarg 0 --dlarg last
Failed with return value 139
test child finished with -1
---- end ----
dlfilter C API: FAILED!
[root@five ~]# fg
-bash: fg: current: no such job
[root@five ~]# ls -la /tmp/dlfilter-test-3360986-perf-data
ls: cannot access '/tmp/dlfilter-test-3360986-perf-data': No such file or directory
[root@five ~]# ls -la /var/home/acme/libexec/perf-core/dlfilters/dlfilter-test-api-v0.so
-rwxr-xr-x. 2 acme acme 17352 Aug 10 15:31 /var/home/acme/libexec/perf-core/dlfilters/dlfilter-test-api-v0.so
[root@five ~]# perf trace -e probe_dlfilter:*/max-stack=10/ perf test -vvv dlfilter
72: dlfilter C API                                                  :
--- start ---
test child forked, pid 3361199
Checking for gcc
Command: gcc --version
gcc (GCC) 11.1.1 20210531 (Red Hat 11.1.1-3)
Copyright (C) 2021 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

dlfilters path: /var/home/acme/libexec/perf-core/dlfilters
Command: cat /tmp/dlfilter-test-3361199-prog.c ; echo
int bar(){};int foo(){bar();};int main(){foo();return 0;}
Command: gcc -g -o /tmp/dlfilter-test-3361199-prog /tmp/dlfilter-test-3361199-prog.c
     0.000 perf/3361199 probe_dlfilter:filter_description(__probe_ip: 140125348678653)
                                       filter_description (/var/home/acme/libexec/perf-core/dlfilters/dlfilter-test-api-v0.so)
                                       test__dlfilter (/var/home/acme/bin/perf)
                                       test_and_print (/var/home/acme/bin/perf)
                                       cmd_test (/var/home/acme/bin/perf)
                                       run_builtin (/var/home/acme/bin/perf)
                                       main (/var/home/acme/bin/perf)
                                       __libc_start_main (/usr/lib64/libc-2.33.so)
Command: objdump -x -dS /tmp/dlfilter-test-3361199-prog

/tmp/dlfilter-test-3361199-prog:     file format elf64-x86-64
/tmp/dlfilter-test-3361199-prog
architecture: i386:x86-64, flags 0x00000112:
EXEC_P, HAS_SYMS, D_PAGED
start address 0x0000000000401020

Program Header:
    PHDR off    0x0000000000000040 vaddr 0x0000000000400040 paddr 0x0000000000400040 align 2**3
         filesz 0x00000000000002d8 memsz 0x00000000000002d8 flags r--
  INTERP off    0x0000000000000318 vaddr 0x0000000000400318 paddr 0x0000000000400318 align 2**0
         filesz 0x000000000000001c memsz 0x000000000000001c flags r--
    LOAD off    0x0000000000000000 vaddr 0x0000000000400000 paddr 0x0000000000400000 align 2**12
         filesz 0x0000000000000498 memsz 0x0000000000000498 flags r--
    LOAD off    0x0000000000001000 vaddr 0x0000000000401000 paddr 0x0000000000401000 align 2**12
         filesz 0x00000000000001c5 memsz 0x00000000000001c5 flags r-x
    LOAD off    0x0000000000002000 vaddr 0x0000000000402000 paddr 0x0000000000402000 align 2**12
         filesz 0x0000000000000158 memsz 0x0000000000000158 flags r--
    LOAD off    0x0000000000002e50 vaddr 0x0000000000403e50 paddr 0x0000000000403e50 align 2**12
         filesz 0x00000000000001cc memsz 0x00000000000001d0 flags rw-
 DYNAMIC off    0x0000000000002e60 vaddr 0x0000000000403e60 paddr 0x0000000000403e60 align 2**3
         filesz 0x0000000000000190 memsz 0x0000000000000190 flags rw-
    NOTE off    0x0000000000000338 vaddr 0x0000000000400338 paddr 0x0000000000400338 align 2**3
         filesz 0x0000000000000020 memsz 0x0000000000000020 flags r--
    NOTE off    0x0000000000000358 vaddr 0x0000000000400358 paddr 0x0000000000400358 align 2**2
         filesz 0x0000000000000044 memsz 0x0000000000000044 flags r--
0x6474e553 off    0x0000000000000338 vaddr 0x0000000000400338 paddr 0x0000000000400338 align 2**3
         filesz 0x0000000000000020 memsz 0x0000000000000020 flags r--
EH_FRAME off    0x0000000000002010 vaddr 0x0000000000402010 paddr 0x0000000000402010 align 2**2
         filesz 0x0000000000000044 memsz 0x0000000000000044 flags r--
   STACK off    0x0000000000000000 vaddr 0x0000000000000000 paddr 0x0000000000000000 align 2**4
         filesz 0x0000000000000000 memsz 0x0000000000000000 flags rw-
   RELRO off    0x0000000000002e50 vaddr 0x0000000000403e50 paddr 0x0000000000403e50 align 2**0
         filesz 0x00000000000001b0 memsz 0x00000000000001b0 flags r--

Dynamic Section:
  NEEDED               libc.so.6
  INIT                 0x0000000000401000
  FINI                 0x00000000004011b8
  INIT_ARRAY           0x0000000000403e50
  INIT_ARRAYSZ         0x0000000000000008
  FINI_ARRAY           0x0000000000403e58
  FINI_ARRAYSZ         0x0000000000000008
  GNU_HASH             0x00000000004003a0
  STRTAB               0x0000000000400408
  SYMTAB               0x00000000004003c0
  STRSZ                0x0000000000000038
  SYMENT               0x0000000000000018
  DEBUG                0x0000000000000000
  RELA                 0x0000000000400468
  RELASZ               0x0000000000000030
  RELAENT              0x0000000000000018
  VERNEED              0x0000000000400448
  VERNEEDNUM           0x0000000000000001
  VERSYM               0x0000000000400440

Version References:
  required from libc.so.6:
    0x09691a75 0x00 02 GLIBC_2.2.5

Sections:
Idx Name          Size      VMA               LMA               File off  Algn
  0 .interp       0000001c  0000000000400318  0000000000400318  00000318  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  1 .note.gnu.property 00000020  0000000000400338  0000000000400338  00000338  2**3
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  2 .note.gnu.build-id 00000024  0000000000400358  0000000000400358  00000358  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  3 .note.ABI-tag 00000020  000000000040037c  000000000040037c  0000037c  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  4 .gnu.hash     0000001c  00000000004003a0  00000000004003a0  000003a0  2**3
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  5 .dynsym       00000048  00000000004003c0  00000000004003c0  000003c0  2**3
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  6 .dynstr       00000038  0000000000400408  0000000000400408  00000408  2**0
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  7 .gnu.version  00000006  0000000000400440  0000000000400440  00000440  2**1
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  8 .gnu.version_r 00000020  0000000000400448  0000000000400448  00000448  2**3
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
  9 .rela.dyn     00000030  0000000000400468  0000000000400468  00000468  2**3
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
 10 .init         0000001b  0000000000401000  0000000000401000  00001000  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
 11 .text         00000195  0000000000401020  0000000000401020  00001020  2**4
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
 12 .fini         0000000d  00000000004011b8  00000000004011b8  000011b8  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
 13 .rodata       00000010  0000000000402000  0000000000402000  00002000  2**3
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
 14 .eh_frame_hdr 00000044  0000000000402010  0000000000402010  00002010  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
 15 .eh_frame     00000100  0000000000402058  0000000000402058  00002058  2**3
                  CONTENTS, ALLOC, LOAD, READONLY, DATA
 16 .init_array   00000008  0000000000403e50  0000000000403e50  00002e50  2**3
                  CONTENTS, ALLOC, LOAD, DATA
 17 .fini_array   00000008  0000000000403e58  0000000000403e58  00002e58  2**3
                  CONTENTS, ALLOC, LOAD, DATA
 18 .dynamic      00000190  0000000000403e60  0000000000403e60  00002e60  2**3
                  CONTENTS, ALLOC, LOAD, DATA
 19 .got          00000010  0000000000403ff0  0000000000403ff0  00002ff0  2**3
                  CONTENTS, ALLOC, LOAD, DATA
 20 .got.plt      00000018  0000000000404000  0000000000404000  00003000  2**3
                  CONTENTS, ALLOC, LOAD, DATA
 21 .data         00000004  0000000000404018  0000000000404018  00003018  2**0
                  CONTENTS, ALLOC, LOAD, DATA
 22 .bss          00000004  000000000040401c  000000000040401c  0000301c  2**0
                  ALLOC
 23 .comment      0000002e  0000000000000000  0000000000000000  0000301c  2**0
                  CONTENTS, READONLY
 24 .gnu.build.attributes 00001978  0000000000406020  0000000000406020  0000304c  2**2
                  CONTENTS, READONLY, OCTETS
 25 .debug_aranges 00000030  0000000000000000  0000000000000000  000049c4  2**0
                  CONTENTS, READONLY, DEBUGGING, OCTETS
 26 .debug_info   00000090  0000000000000000  0000000000000000  000049f4  2**0
                  CONTENTS, READONLY, DEBUGGING, OCTETS
 27 .debug_abbrev 0000006a  0000000000000000  0000000000000000  00004a84  2**0
                  CONTENTS, READONLY, DEBUGGING, OCTETS
 28 .debug_line   00000065  0000000000000000  0000000000000000  00004aee  2**0
                  CONTENTS, READONLY, DEBUGGING, OCTETS
 29 .debug_str    00000050  0000000000000000  0000000000000000  00004b53  2**0
                  CONTENTS, READONLY, DEBUGGING, OCTETS
 30 .debug_line_str 0000002d  0000000000000000  0000000000000000  00004ba3  2**0
                  CONTENTS, READONLY, DEBUGGING, OCTETS
SYMBOL TABLE:
0000000000400318 l    d  .interp	0000000000000000              .interp
0000000000400338 l    d  .note.gnu.property	0000000000000000              .note.gnu.property
0000000000400358 l    d  .note.gnu.build-id	0000000000000000              .note.gnu.build-id
000000000040037c l    d  .note.ABI-tag	0000000000000000              .note.ABI-tag
00000000004003a0 l    d  .gnu.hash	0000000000000000              .gnu.hash
00000000004003c0 l    d  .dynsym	0000000000000000              .dynsym
0000000000400408 l    d  .dynstr	0000000000000000              .dynstr
0000000000400440 l    d  .gnu.version	0000000000000000              .gnu.version
0000000000400448 l    d  .gnu.version_r	0000000000000000              .gnu.version_r
0000000000400468 l    d  .rela.dyn	0000000000000000              .rela.dyn
0000000000401000 l    d  .init	0000000000000000              .init
0000000000401020 l    d  .text	0000000000000000              .text
00000000004011b8 l    d  .fini	0000000000000000              .fini
0000000000402000 l    d  .rodata	0000000000000000              .rodata
0000000000402010 l    d  .eh_frame_hdr	0000000000000000              .eh_frame_hdr
0000000000402058 l    d  .eh_frame	0000000000000000              .eh_frame
0000000000403e50 l    d  .init_array	0000000000000000              .init_array
0000000000403e58 l    d  .fini_array	0000000000000000              .fini_array
0000000000403e60 l    d  .dynamic	0000000000000000              .dynamic
0000000000403ff0 l    d  .got	0000000000000000              .got
0000000000404000 l    d  .got.plt	0000000000000000              .got.plt
0000000000404018 l    d  .data	0000000000000000              .data
000000000040401c l    d  .bss	0000000000000000              .bss
0000000000000000 l    d  .comment	0000000000000000              .comment
0000000000406020 l    d  .gnu.build.attributes	0000000000000000              .gnu.build.attributes
0000000000000000 l    d  .debug_aranges	0000000000000000              .debug_aranges
0000000000000000 l    d  .debug_info	0000000000000000              .debug_info
0000000000000000 l    d  .debug_abbrev	0000000000000000              .debug_abbrev
0000000000000000 l    d  .debug_line	0000000000000000              .debug_line
0000000000000000 l    d  .debug_str	0000000000000000              .debug_str
0000000000000000 l    d  .debug_line_str	0000000000000000              .debug_line_str
0000000000000000 l    df *ABS*	0000000000000000              /usr/lib/gcc/x86_64-redhat-linux/11/../../../../lib64/crt1.o
000000000040104f l       .text	0000000000000000              .hidden .annobin_lto
000000000040104f l       .text	0000000000000000              .hidden .annobin_lto_end
0000000000401020 l       .text	0000000000000000              .hidden .annobin_lto.hot
0000000000401020 l       .text	0000000000000000              .hidden .annobin_lto_end.hot
0000000000401020 l       .text	0000000000000000              .hidden .annobin_lto.unlikely
0000000000401020 l       .text	0000000000000000              .hidden .annobin_lto_end.unlikely
0000000000401020 l       .text	0000000000000000              .hidden .annobin_lto.startup
0000000000401020 l       .text	0000000000000000              .hidden .annobin_lto_end.startup
0000000000401020 l       .text	0000000000000000              .hidden .annobin_lto.exit
0000000000401020 l       .text	0000000000000000              .hidden .annobin_lto_end.exit
000000000040037c l     O .note.ABI-tag	0000000000000020              __abi_tag
000000000040104f l       .text	0000000000000000              .hidden .annobin_lto
000000000040104f l       .text	0000000000000000              .hidden .annobin_lto_end
0000000000401020 l       .text	0000000000000000              .hidden .annobin_lto.hot
0000000000401020 l       .text	0000000000000000              .hidden .annobin_lto_end.hot
0000000000401020 l       .text	0000000000000000              .hidden .annobin_lto.unlikely
0000000000401020 l       .text	0000000000000000              .hidden .annobin_lto_end.unlikely
0000000000401020 l       .text	0000000000000000              .hidden .annobin_lto.startup
0000000000401020 l       .text	0000000000000000              .hidden .annobin_lto_end.startup
0000000000401020 l       .text	0000000000000000              .hidden .annobin_lto.exit
0000000000401020 l       .text	0000000000000000              .hidden .annobin_lto_end.exit
0000000000401050 l       .text	0000000000000000              .hidden .annobin_lto
0000000000401055 l       .text	0000000000000000              .hidden .annobin_lto_end
0000000000401020 l       .text	0000000000000000              .hidden .annobin_lto.hot
0000000000401020 l       .text	0000000000000000              .hidden .annobin_lto_end.hot
0000000000401020 l       .text	0000000000000000              .hidden .annobin_lto.unlikely
0000000000401020 l       .text	0000000000000000              .hidden .annobin_lto_end.unlikely
0000000000401020 l       .text	0000000000000000              .hidden .annobin_lto.startup
0000000000401020 l       .text	0000000000000000              .hidden .annobin_lto_end.startup
0000000000401020 l       .text	0000000000000000              .hidden .annobin_lto.exit
0000000000401020 l       .text	0000000000000000              .hidden .annobin_lto_end.exit
0000000000401050 l       .text	0000000000000000              .hidden .annobin__dl_relocate_static_pie.start
0000000000401055 l       .text	0000000000000000              .hidden .annobin__dl_relocate_static_pie.end
0000000000000000 l    df *ABS*	0000000000000000              crtstuff.c
0000000000401060 l     F .text	0000000000000000              deregister_tm_clones
0000000000401090 l     F .text	0000000000000000              register_tm_clones
00000000004010d0 l     F .text	0000000000000000              __do_global_dtors_aux
000000000040401c l     O .bss	0000000000000001              completed.0
0000000000403e58 l     O .fini_array	0000000000000000              __do_global_dtors_aux_fini_array_entry
0000000000401100 l     F .text	0000000000000000              frame_dummy
0000000000403e50 l     O .init_array	0000000000000000              __frame_dummy_init_array_entry
0000000000000000 l    df *ABS*	0000000000000000              dlfilter-test-3361199-prog.c
0000000000000000 l    df *ABS*	0000000000000000              crtstuff.c
0000000000402154 l     O .eh_frame	0000000000000000              __FRAME_END__
0000000000000000 l    df *ABS*	0000000000000000              
0000000000403e58 l       .init_array	0000000000000000              __init_array_end
0000000000403e60 l     O .dynamic	0000000000000000              _DYNAMIC
0000000000403e50 l       .init_array	0000000000000000              __init_array_start
0000000000402010 l       .eh_frame_hdr	0000000000000000              __GNU_EH_FRAME_HDR
0000000000404000 l     O .got.plt	0000000000000000              _GLOBAL_OFFSET_TABLE_
00000000004011b0 g     F .text	0000000000000005              __libc_csu_fini
0000000000404018  w      .data	0000000000000000              data_start
000000000040401c g       .data	0000000000000000              _edata
0000000000401106 g     F .text	0000000000000007              bar
00000000004011b8 g     F .fini	0000000000000000              .hidden _fini
0000000000000000       F *UND*	0000000000000000              __libc_start_main@@GLIBC_2.2.5
0000000000404018 g       .data	0000000000000000              __data_start
0000000000000000  w      *UND*	0000000000000000              __gmon_start__
0000000000402008 g     O .rodata	0000000000000000              .hidden __dso_handle
0000000000402000 g     O .rodata	0000000000000004              _IO_stdin_used
0000000000401140 g     F .text	0000000000000065              __libc_csu_init
000000000040110d g     F .text	0000000000000011              foo
0000000000404020 g       .bss	0000000000000000              _end
0000000000401050 g     F .text	0000000000000005              .hidden _dl_relocate_static_pie
0000000000401020 g     F .text	000000000000002f              _start
000000000040401c g       .bss	0000000000000000              __bss_start
000000000040111e g     F .text	0000000000000015              main
0000000000404020 g     O .data	0000000000000000              .hidden __TMC_END__
0000000000401000 g     F .init	0000000000000000              .hidden _init



Disassembly of section .init:

0000000000401000 <_init>:
  401000:	f3 0f 1e fa          	endbr64 
  401004:	48 83 ec 08          	sub    $0x8,%rsp
  401008:	48 8b 05 e9 2f 00 00 	mov    0x2fe9(%rip),%rax        # 403ff8 <__gmon_start__>
  40100f:	48 85 c0             	test   %rax,%rax
  401012:	74 02                	je     401016 <_init+0x16>
  401014:	ff d0                	callq  *%rax
  401016:	48 83 c4 08          	add    $0x8,%rsp
  40101a:	c3                   	retq   

Disassembly of section .text:

0000000000401020 <_start>:
  401020:	f3 0f 1e fa          	endbr64 
  401024:	31 ed                	xor    %ebp,%ebp
  401026:	49 89 d1             	mov    %rdx,%r9
  401029:	5e                   	pop    %rsi
  40102a:	48 89 e2             	mov    %rsp,%rdx
  40102d:	48 83 e4 f0          	and    $0xfffffffffffffff0,%rsp
  401031:	50                   	push   %rax
  401032:	54                   	push   %rsp
  401033:	49 c7 c0 b0 11 40 00 	mov    $0x4011b0,%r8
  40103a:	48 c7 c1 40 11 40 00 	mov    $0x401140,%rcx
  401041:	48 c7 c7 1e 11 40 00 	mov    $0x40111e,%rdi
  401048:	ff 15 a2 2f 00 00    	callq  *0x2fa2(%rip)        # 403ff0 <__libc_start_main@GLIBC_2.2.5>
  40104e:	f4                   	hlt    

000000000040104f <.annobin_lto>:
  40104f:	90                   	nop

0000000000401050 <_dl_relocate_static_pie>:
  401050:	f3 0f 1e fa          	endbr64 
  401054:	c3                   	retq   

0000000000401055 <.annobin__dl_relocate_static_pie.end>:
  401055:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40105c:	00 00 00 
  40105f:	90                   	nop

0000000000401060 <deregister_tm_clones>:
  401060:	b8 20 40 40 00       	mov    $0x404020,%eax
  401065:	48 3d 20 40 40 00    	cmp    $0x404020,%rax
  40106b:	74 13                	je     401080 <deregister_tm_clones+0x20>
  40106d:	b8 00 00 00 00       	mov    $0x0,%eax
  401072:	48 85 c0             	test   %rax,%rax
  401075:	74 09                	je     401080 <deregister_tm_clones+0x20>
  401077:	bf 20 40 40 00       	mov    $0x404020,%edi
  40107c:	ff e0                	jmpq   *%rax
  40107e:	66 90                	xchg   %ax,%ax
  401080:	c3                   	retq   
  401081:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
  401088:	00 00 00 00 
  40108c:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000401090 <register_tm_clones>:
  401090:	be 20 40 40 00       	mov    $0x404020,%esi
  401095:	48 81 ee 20 40 40 00 	sub    $0x404020,%rsi
  40109c:	48 89 f0             	mov    %rsi,%rax
  40109f:	48 c1 ee 3f          	shr    $0x3f,%rsi
  4010a3:	48 c1 f8 03          	sar    $0x3,%rax
  4010a7:	48 01 c6             	add    %rax,%rsi
  4010aa:	48 d1 fe             	sar    %rsi
  4010ad:	74 11                	je     4010c0 <register_tm_clones+0x30>
  4010af:	b8 00 00 00 00       	mov    $0x0,%eax
  4010b4:	48 85 c0             	test   %rax,%rax
  4010b7:	74 07                	je     4010c0 <register_tm_clones+0x30>
  4010b9:	bf 20 40 40 00       	mov    $0x404020,%edi
  4010be:	ff e0                	jmpq   *%rax
  4010c0:	c3                   	retq   
  4010c1:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
  4010c8:	00 00 00 00 
  4010cc:	0f 1f 40 00          	nopl   0x0(%rax)

00000000004010d0 <__do_global_dtors_aux>:
  4010d0:	f3 0f 1e fa          	endbr64 
  4010d4:	80 3d 41 2f 00 00 00 	cmpb   $0x0,0x2f41(%rip)        # 40401c <completed.0>
  4010db:	75 13                	jne    4010f0 <__do_global_dtors_aux+0x20>
  4010dd:	55                   	push   %rbp
  4010de:	48 89 e5             	mov    %rsp,%rbp
  4010e1:	e8 7a ff ff ff       	callq  401060 <deregister_tm_clones>
  4010e6:	c6 05 2f 2f 00 00 01 	movb   $0x1,0x2f2f(%rip)        # 40401c <completed.0>
  4010ed:	5d                   	pop    %rbp
  4010ee:	c3                   	retq   
  4010ef:	90                   	nop
  4010f0:	c3                   	retq   
  4010f1:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
  4010f8:	00 00 00 00 
  4010fc:	0f 1f 40 00          	nopl   0x0(%rax)

0000000000401100 <frame_dummy>:
  401100:	f3 0f 1e fa          	endbr64 
  401104:	eb 8a                	jmp    401090 <register_tm_clones>

0000000000401106 <bar>:
  401106:	55                   	push   %rbp
  401107:	48 89 e5             	mov    %rsp,%rbp
  40110a:	90                   	nop
  40110b:	5d                   	pop    %rbp
  40110c:	c3                   	retq   

000000000040110d <foo>:
  40110d:	55                   	push   %rbp
  40110e:	48 89 e5             	mov    %rsp,%rbp
  401111:	b8 00 00 00 00       	mov    $0x0,%eax
  401116:	e8 eb ff ff ff       	callq  401106 <bar>
  40111b:	90                   	nop
  40111c:	5d                   	pop    %rbp
  40111d:	c3                   	retq   

000000000040111e <main>:
  40111e:	55                   	push   %rbp
  40111f:	48 89 e5             	mov    %rsp,%rbp
  401122:	b8 00 00 00 00       	mov    $0x0,%eax
  401127:	e8 e1 ff ff ff       	callq  40110d <foo>
  40112c:	b8 00 00 00 00       	mov    $0x0,%eax
  401131:	5d                   	pop    %rbp
  401132:	c3                   	retq   
  401133:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
  40113a:	00 00 00 
  40113d:	0f 1f 00             	nopl   (%rax)

0000000000401140 <__libc_csu_init>:
  401140:	f3 0f 1e fa          	endbr64 
  401144:	41 57                	push   %r15
  401146:	4c 8d 3d 03 2d 00 00 	lea    0x2d03(%rip),%r15        # 403e50 <__frame_dummy_init_array_entry>
  40114d:	41 56                	push   %r14
  40114f:	49 89 d6             	mov    %rdx,%r14
  401152:	41 55                	push   %r13
  401154:	49 89 f5             	mov    %rsi,%r13
  401157:	41 54                	push   %r12
  401159:	41 89 fc             	mov    %edi,%r12d
  40115c:	55                   	push   %rbp
  40115d:	48 8d 2d f4 2c 00 00 	lea    0x2cf4(%rip),%rbp        # 403e58 <__do_global_dtors_aux_fini_array_entry>
  401164:	53                   	push   %rbx
  401165:	4c 29 fd             	sub    %r15,%rbp
  401168:	48 83 ec 08          	sub    $0x8,%rsp
  40116c:	e8 8f fe ff ff       	callq  401000 <_init>
  401171:	48 c1 fd 03          	sar    $0x3,%rbp
  401175:	74 1f                	je     401196 <__libc_csu_init+0x56>
  401177:	31 db                	xor    %ebx,%ebx
  401179:	0f 1f 80 00 00 00 00 	nopl   0x0(%rax)
  401180:	4c 89 f2             	mov    %r14,%rdx
  401183:	4c 89 ee             	mov    %r13,%rsi
  401186:	44 89 e7             	mov    %r12d,%edi
  401189:	41 ff 14 df          	callq  *(%r15,%rbx,8)
  40118d:	48 83 c3 01          	add    $0x1,%rbx
  401191:	48 39 dd             	cmp    %rbx,%rbp
  401194:	75 ea                	jne    401180 <__libc_csu_init+0x40>
  401196:	48 83 c4 08          	add    $0x8,%rsp
  40119a:	5b                   	pop    %rbx
  40119b:	5d                   	pop    %rbp
  40119c:	41 5c                	pop    %r12
  40119e:	41 5d                	pop    %r13
  4011a0:	41 5e                	pop    %r14
  4011a2:	41 5f                	pop    %r15
  4011a4:	c3                   	retq   
  4011a5:	66 66 2e 0f 1f 84 00 	data16 nopw %cs:0x0(%rax,%rax,1)
  4011ac:	00 00 00 00 

00000000004011b0 <__libc_csu_fini>:
  4011b0:	f3 0f 1e fa          	endbr64 
  4011b4:	c3                   	retq   

Disassembly of section .fini:

00000000004011b8 <_fini>:
  4011b8:	f3 0f 1e fa          	endbr64 
  4011bc:	48 83 ec 08          	sub    $0x8,%rsp
  4011c0:	48 83 c4 08          	add    $0x8,%rsp
  4011c4:	c3                   	retq   
Creating new host machine structure
Command: /var/home/acme/bin/perf script -i /tmp/dlfilter-test-3361199-perf-data -D

0 [0x90]: event: 64
.
. ... raw event: size 144 bytes
.  0000:  40 00 00 00 00 00 90 00 00 00 00 00 80 00 00 00  @...............
.  0010:  04 00 00 00 00 00 00 00 01 00 00 00 00 00 00 00  ................
.  0020:  8f 03 01 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
.  0030:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
.  0040:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
.  0050:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
.  0060:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
.  0070:  00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
.  0080:  00 00 00 00 00 00 00 00 63 00 00 00 00 00 00 00  ........c.......

-1 -1 0 [0x90]: PERF_RECORD_ATTR
0x90 [0x20]: event: 3
.
. ... raw event: size 32 bytes
.  0000:  03 00 00 00 02 00 20 00 39 30 00 00 3a 30 00 00  ...... .90..:0..
.  0010:  74 65 73 74 2d 70 72 6f 67 00 00 00 00 00 00 00  test-prog.......

-1 -1 0x90 [0x20]: PERF_RECORD_COMM: test-prog:12345/12346

0xb0 [0x48]: event: 1
.
. ... raw event: size 72 bytes
.  0000:  01 00 00 00 02 00 48 00 39 30 00 00 3a 30 00 00  ......H.90..:0..
.  0010:  00 00 40 00 00 00 00 00 00 00 01 00 00 00 00 00  ..@.............
.  0020:  00 00 00 00 00 00 00 00 2f 74 6d 70 2f 64 6c 66  ......../tmp/dlf
.  0030:  69 6c 74 65 72 2d 74 65 73 74 2d 33 33 36 31 31  ilter-test-33611
.  0040:  39 39 2d 70 72 6f 67 00                          99-prog.        

-1 -1 0xb0 [0x48]: PERF_RECORD_MMAP 12345/12346: [0x400000(0x10000) @ 0]: x /tmp/dlfilter-test-3361199-prog

0xf8 [0x48]: event: 9
.
. ... raw event: size 72 bytes
.  0000:  09 00 00 00 02 00 48 00 63 00 00 00 00 00 00 00  ......H.c.......
.  0010:  0d 11 40 00 00 00 00 00 39 30 00 00 3a 30 00 00  ..@.....90..:0..
.  0020:  d2 02 96 49 00 00 00 00 06 11 40 00 00 00 00 00  <D2>..I......@.....
.  0030:  65 00 00 00 00 00 00 00 1f 00 00 00 00 00 00 00  e...............
.  0040:  39 c3 60 20 00 00 00 00                          9<C3>` ....        

31 1234567890 0xf8 [0x48]: PERF_RECORD_SAMPLE(IP, 0x2): 12345/12346: 0x40110d period: 543212345 addr: 0x401106
 ... thread: test-prog:12346
 ...... dso: /tmp/dlfilter-test-3361199-prog
       test-prog 12346 [031]     1.234567:  543212345 branches:HG:            40110d foo+0x0 (/tmp/dlfilter-test-3361199-prog) =>           401106 bar+0x0 (/tmp/dlfilter-test-3361199-prog)
Command: /var/home/acme/bin/perf script -i /tmp/dlfilter-test-3361199-perf-data --dlfilter /var/home/acme/libexec/perf-core/dlfilters/dlfilter-test-api-v0.so --dlarg first --dlarg 3 --dlarg 4198669 --dlarg 4198662 --dlarg 0 --dlarg last
Failed with return value 139
test child finished with -1
---- end ----
dlfilter C API: FAILED!
[root@five ~]# 


