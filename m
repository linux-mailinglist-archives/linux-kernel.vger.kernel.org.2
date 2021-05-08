Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AEED9376E59
	for <lists+linux-kernel@lfdr.de>; Sat,  8 May 2021 04:03:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230308AbhEHCDv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 May 2021 22:03:51 -0400
Received: from out1-smtp.messagingengine.com ([66.111.4.25]:34011 "EHLO
        out1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229775AbhEHCDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 May 2021 22:03:50 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.42])
        by mailout.nyi.internal (Postfix) with ESMTP id 5D0855C0175;
        Fri,  7 May 2021 22:02:49 -0400 (EDT)
Received: from imap21 ([10.202.2.71])
  by compute2.internal (MEProxy); Fri, 07 May 2021 22:02:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=serhei.io; h=
        mime-version:message-id:date:from:to:cc:subject:content-type; s=
        fm1; bh=50Nd+RXvqPLoE5XVpUtGmA7kEhGxC2m5krLy3yY6uRg=; b=F44ncW16
        HzvVW+aYM5WKL8XPs/7pq1eWpKU0qW1tX9hB7jboR1wtdP7vP1pyL7TvufqZC3/V
        +BEK1T7OgUEbhJYOq8b+JZrZmEGAFsFrhAZFaTwunRAWQSFwEBWUk62rlnnh5FjS
        gvb1sGkss9b44D6aV7ASWHA2L6ReZQNJVyTFbVjE7TCJfaHRe/Xyg+syGLnkFmtU
        m9bVA2V5KV519djC/HpI4kOlYlMWHvW+ojzQBsAW4R9oXI5FFzTrvtb74966u3Sq
        752goMsCUs957wJG5PCmuxGklqwqLOOfhFJsFzkAhkZXXYzixU6xvJNL6/YRDiWe
        cIualYm03f70yA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=50Nd+RXvqPLoE5XVpUtGmA7kEhGxC
        2m5krLy3yY6uRg=; b=aIn1IQd24e20rOB7Cz7XO+R5Scx+o0FXLR+TyvMc5HHBT
        NKNp5HoHkKgCg8ANHG2PZrQ2SrlGI8oVL3VhQiORiB1vdSEQyl3Su0hdRvzHURdl
        EHJ88HoT1XvSZvZX9auW6BMWOh7NgqXAW3YuAjISx0GgI0rmRTdAbs7hH6d1KMFK
        77tiPYvbkN/ivBC4nfckvRdfFnPAXOzUu1G+92zIM2Sy/nz+HCP/innr9ol/zO8f
        SfgwEcBhfXhtorAkrzS+n3FsBNnDunQb1vsBn34J9fgkmDHftxzNO4Nwlbn7JuVk
        Ogt0uAICvKjrDD1ts9c9J4JXPKD9VUrGePTM0hmtA==
X-ME-Sender: <xms:SPGVYMhdH0jTJOV45yR7iRCBWADeZ_Wk1Oomixs6eNGNs1tMztpyLw>
    <xme:SPGVYFC68g_LKTW7LhFd_s2IojWgzHa8F0FpjTkEW8slbt-dHxjQaQPHvWc1zNMhO
    dsMD67He0W-E1MmUA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrvdegfedgheefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfffhffvufgtsehttdertd
    erredtnecuhfhrohhmpedfufgvrhhhvghiucforghkrghrohhvfdcuoehmvgesshgvrhhh
    vghirdhioheqnecuggftrfgrthhtvghrnheptdffieehteelieekledtkefhtdethfdtfe
    etveelhfegtdeljedtvdetkeetffevnecuffhomhgrihhnpehsohhurhgtvgifrghrvgdr
    ohhrghdpfhgvughorhgrphhrohhjvggtthdrohhrghdprhgvughhrghtrdgtohhmnecuve
    hluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgvsehsvghr
    hhgvihdrihho
X-ME-Proxy: <xmx:SPGVYEGM3fa73OkWA_Vr8cjBgh-nw8LcOET5UqZ0569C3zha-ZYQVg>
    <xmx:SPGVYNSJJhc8D3_pszCBnegNDG2COA0RE043Tj1FVR4QX4X9LWbP9A>
    <xmx:SPGVYJzr8J4L__n1yVaq51VNYHlHUpw7q-uwGRxMrn3lCf_99uNyIw>
    <xmx:SfGVYHaQXTmvc7a38JhcvAT_5uzec6MCCCeGfUvNFSntMp44AQP3_A>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id CB68751C0060; Fri,  7 May 2021 22:02:48 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-448-gae190416c7-fm-20210505.004-gae190416
Mime-Version: 1.0
Message-Id: <2587f978-3619-4ed7-ac31-1cb0c0d29b31@www.fastmail.com>
Date:   Fri, 07 May 2021 22:02:28 -0400
From:   "Serhei Makarov" <me@serhei.io>
To:     systemtap <systemtap@sourceware.org>
Cc:     linux-kernel@vger.kernel.org, lwn@lwn.net
Subject: systemtap release 4.5
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SystemTap team announces release 4.5

Enhancements to this release include updated Java probing support,
floating-point variable access via $context variables, $context
variable support for enum values, bpf uconversions tapset, significant
concurrency/locking improvements for stable operation on large busy
servers.

= Where to get it

  https://sourceware.org/systemtap/ - our project page
  https://sourceware.org/systemtap/ftp/releases/
  https://koji.fedoraproject.org/koji/packageinfo?packageID=615
  git tag release-4.5 (commit 0eba8a46bc99c66e5dd274a9a4d661fe08ac4b8a)

  There have been over 155 commits since the last release.
  There have been 23 bugs fixed / features added since the last release.

= SystemTap frontend (stap) changes

- Enum values can now be accessed as $context variables (PR25346).

- Executables for which stap has execute but not read permissions
  (--x--x--x) can now be probed with build-id probes and debuginfod.
  This allows probing some setuid programs (PR27251).

- Enabled the -c option to work with the bpf backend (PR25177).

- Floating point variables may now be accessed directly as normal
  $context variables.  32-bit floats are automatically widened to
  doubles. (PR13838)

- On startup, stap explains the [man FOO] diagnostic syntax.  But we bet
  those reading this note already knew it!

= SystemTap backend changes

- Numerous fixes and improvements to concurrency control in the uprobes
  and transport subsystems, to more reliably handle large busy machines.

- Java probing support has been updated to work with the latest versions of the
  JVM and byteman (PR27739).

- Added VMA-tracking support to the stapdyn backend.

- The kernel runtime now uses procfs as the default transport mechanism.

- stap-server better handles NSS dbm->sqlite database transitions.

- A wider variety of SecureBoot MOK keys are now recognized for
  more reliable triggering of stap-server module signing.  Document
  some additional lockdown/secureboot administrative escape options.
  (PR26665)

= SystemTap tapset changes

- An initial version of the bpf/uconversions.stp tapset
  provides tapset functions such as user_long_error()
  to access values in userspace.

= SystemTap sample scripts

- All 190+ examples can be found at https://sourceware.org/systemtap/examples/

- The floatingpoint.stp sample script has been updated to use new
   floating-point variable access syntax.

- New sample scripts:

  cve-2011-4127.stp
  Historical emergency security band-aid script for example purposes only

= Examples of tested kernel versions 

  2.6.32 (RHEL6 i686, x86_64)
  3.10.0 (RHEL7 x86_64)
  4.15.0 (Ubuntu 18.04 x86_64)
  4.18.0 (RHEL8 x86_64, aarch64, ppc64le, s390x)
  5.3.8  (Fedora 30 i686)
  5.9.0-rc7   (Fedora rawhide x86_64)
  5.10.0-rc1  (Fedora rawhide x86_64)
  5.11.11 (Fedora 33 x86_64)
  5.11.15 (Fedora 34 x86_64)
  5.11.16 (Fedora 32 x86_64)
  5.12.0-rc2 (Fedora rawhide x86_64)

= Known issues with this release

- Some of the testcases for the BPF backend have uncovered an issue
  in the kernel's BPF runtime that can deadlock the entire kernel.
  The problem has been reported upstream. It was first seen during
  testing on kernel 5.11-rc6 but may occur intermittently in earlier
  kernel versions.
  More info at https://bugzilla.redhat.com/show_bug.cgi?id=1938312

- There are known issues on kernel 5.10+ after adapting to set_fs()
  removal, with some memory accesses that previously returned valid data
  instead returning -EFAULT (see PR26811).

- An sdt probe cannot parse a parameter that uses a segment register.
  (PR13429)

- The presence of a line such as
      *CFLAGS += $(call cc-option, -fno-var-tracking-assignments)
  in older linux kernel Makefile unnecessarily reduces debuginfo quality,
  consider removing that line if you build kernels.  Linux 5.10+ fixes this.

= Contributors for this release

Aaron Merey, Alice Zhang, Cosmin Tanislav*, Craig Ringer, Ding Hui*,
Frank Ch. Eigler, Guillaume Morin*, Jamie Bainbridge*, Kamil Dudka*,
Martin Cermak, Serhei Makarov, Stan Cox, Sultan Alsawaf, Sven Wegener*,
Tom Stellard*, William Cohen, Yichun Zhang (agentzh)

Special thanks to new contributors, marked with '*' above.

= Bugs fixed for this release <https://sourceware.org/PR#####>

15387 Add stapdyn functions to get/set errno
25177 stap --bpf -c does not work as specified
25346 support enum context variables
26844 off-by-one error in the output of sprint_ubacktrace()
26958 kernel crash when staprun ko which build id not matched
27001 4.4 runtime/transport/transport.c: security_locked_down can be undeclared depending the kernel config
27031 bpf: 'missing conversion specifier' when printing @var()
27044 lock loop on some conditional probes
27067 stapusr regression in staprun
27152 Missing tracepoints for for stap --bpf -L 'kernel.trace("*")'
27168 configure.ac contains non-posix test operator
27185 Reduce code duplication in conversions stress tests
27186 Document CONTEXT variable in embedded C docs
27251 build-id based probes should support unreadable executables via debuginfod
27273 kernel 5.11 porting
27274 stap: staptree.h:1349: virtual update_visitor::~update_visitor(): Assertion `values.empty()' failed.
27378 stap-server should support cert databases without nss dbm:
27392 build fails with --enable-htmldocs
27553 broken usym* lookups for some executables
27658 Swallowed spawn error (due to "Cannot allocate memory") causes unrelated problems later in build process (pass2)
27739 port java probing support to modern jvm/byteman
27785 The ioctl_handler.stp example causes stap to segmentation fault
27802 recent commit breaks --libexecdir 
