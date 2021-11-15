Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7965F451C24
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Nov 2021 01:11:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355508AbhKPANT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Nov 2021 19:13:19 -0500
Received: from out3-smtp.messagingengine.com ([66.111.4.27]:40271 "EHLO
        out3-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1350889AbhKOVkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Nov 2021 16:40:42 -0500
Received: from compute6.internal (compute6.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 46FD75C02C2;
        Mon, 15 Nov 2021 16:37:43 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute6.internal (MEProxy); Mon, 15 Nov 2021 16:37:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=serhei.io; h=
        mime-version:message-id:in-reply-to:references:date:from:to:cc
        :subject:content-type:content-transfer-encoding; s=fm3; bh=fkvNj
        Ek4/frl4xX+yyX/A1euDQw25Cz65x5g51mJAPk=; b=tpdjB+01IUUjQp35Td5tl
        FZhXgcZ4UXLSmqESrvl60gq4KVzKGYGWKr2gY+vrBiWrGg4kA5LuN1spKPIyO+Qx
        MpJk/qGezeQzGf0lzHQAbeP7t+f3DUrSU+UShy4LmkRLt35zLJaz156O1A7/vDDo
        FKN5sH7Df03rysVRN5n+iCxWwwozXioZX3vuTO9Wr9e/skn7uBoaSwoXoyzXjf8C
        uUzq+ER3/066e6iZvlTyq35UYC6bvarY0MT9LyuQLKSwlPX5UQOg0DHRZ8EttFYk
        rhBQaH4b5hpwwEzE3/MF/ThzdOO9ZYBpy43+8u6bSLm/e21xQrSuuxpMGD33Kwhf
        w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=fkvNjEk4/frl4xX+yyX/A1euDQw25Cz65x5g51mJA
        Pk=; b=GrbdKv7rDSn4oXlNIwGFNItpos4Vzpk71u3THKgGVWWm4w3LYNDhzuj7F
        D7tnlVU4d4971mWTmStE81nEp35xhqBVTuqTcJMa1ntsG/h1a0q9Hx3/ogglZTzR
        nSiPLEMl6LHKHV4VvP6zUD21aoBp8TNKF25ZUU7ELkII8alPIG3vAE5HkPtw1CiR
        JbqsMBXB8mSXVimXwknB2Pnok0HYF28QPJJP1hHeeDP6cpVZqOdMeVsZ/2PlzApQ
        g5daXt5ZGDFpcYajMf3/pX3Z5lbew71r5+vXNTYImitR4BYBTtuvc1iOQEwAVAL8
        uvHFakafD+ipejMEhBZ0telwy+uig==
X-ME-Sender: <xms:J9OSYUURXiGrRtKCvXnDPOnW0A1EDWhKstd6Byw3UsOHjYWrXj_MFQ>
    <xme:J9OSYYl0I8Lfx3sSpE90chHcsahkanTM__0jjzY-4DP1lZQNVct6deifUYt2B6e8i
    NObjd2DtYTl4xscSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvuddrfedtgdduvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefofgggkfgjfhffhffvufgtgfesth
    hqredtreerjeenucfhrhhomhepfdfuvghrhhgvihcuofgrkhgrrhhovhdfuceomhgvsehs
    vghrhhgvihdrihhoqeenucggtffrrghtthgvrhhnpeefledtgfeltdffiedtkefggeehke
    fhvdffgeejveduudegledtieehjeevhfegudenucffohhmrghinhepshhouhhrtggvfigr
    rhgvrdhorhhgpdhfvgguohhrrghprhhojhgvtghtrdhorhhgnecuvehluhhsthgvrhfuih
    iivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepmhgvsehsvghrhhgvihdrihho
X-ME-Proxy: <xmx:J9OSYYYMeLchBxJZuvNn8XkbIoYLPm4DOZFFaaPsNOsw4HbFoG8r5A>
    <xmx:J9OSYTUlyf39cNq0ErU-3kZZpJAdChC7k8pXs2bgFmuk9bw2vTURpw>
    <xmx:J9OSYek5MkVBpVIeCcHgp8gu0KDHwvgkSZRN9ys4q7fceSg0xCODKw>
    <xmx:J9OSYVv062fy00v9jU5LtZD2Oh_oi99dXO5ntVZYEO_EeA6sG90FnA>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 074D22740217; Mon, 15 Nov 2021 16:37:42 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-1371-g2296cc3491-fm-20211109.003-g2296cc34
Mime-Version: 1.0
Message-Id: <2188aa33-9ca2-497a-a9fd-4af28dfe250e@www.fastmail.com>
In-Reply-To: <2587f978-3619-4ed7-ac31-1cb0c0d29b31@www.fastmail.com>
References: <2587f978-3619-4ed7-ac31-1cb0c0d29b31@www.fastmail.com>
Date:   Mon, 15 Nov 2021 16:36:04 -0500
From:   "Serhei Makarov" <me@serhei.io>
To:     systemtap@sourceware.org
Cc:     linux-kernel@vger.kernel.org, lwn@lwn.net
Subject: systemtap release 4.6
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The SystemTap team announces release 4.6

support for 64-bit RISC-V architecture, liveness analysis for guru-mode =
write operations,
bpf syscall_any and abort() tapsets, bpf foreach iteration of multi-key =
arrays,
return of inter-cpu output ordering

=3D Where to get it

  https://sourceware.org/systemtap/ - our project page
  https://sourceware.org/systemtap/ftp/releases/
  https://koji.fedoraproject.org/koji/packageinfo?packageID=3D615
  git tag release-4.6 (commit 2e9f2f6967e44ce2bf8f34932b5bdd738ece2161)

  There have been over 149 commits since the last release.
  There have been 25 bugs fixed / features added since the last release.

=3D SystemTap frontend (stap) changes

- stap-prep now tries to download the main kernel debuginfo file from
  a debuginfod server, if configured.

=3D SystemTap backend changes

- SystemTap has added support for the 64-bit RISC-V architecture.

- SystemTap now uses DynInst to perform a liveness analysis on
  target variables and warn when a guru-mode modification to a variable
  will have no effect. The liveness analysis is currently done on
  x86_64, PowerPC, and AArch64.

- The kernel-user relayfs transport again sorts messages into a total
  time order across CPUs.  High output-volume scripts may need a
  larger "-s BUF" parameter to reliably transfer.  "-b" bulk mode
  is also available again as an alternative.
 =20
- The bpf backend now supports foreach iteration in multi-key associativ=
e arrays.

=3D SystemTap tapset changes

- Updated syscall_any tapset mapping to include newer syscalls.

- syscall_any tapset can be used by the bpf backend.

- abort() tapset can be used by the bpf backend.

=3D SystemTap sample scripts

- All 190+ examples can be found at https://sourceware.org/systemtap/exa=
mples/

- New sample scripts:

   io/traceaio.stp
   Trace calls to io_submit, logging iocbs and iovecs.

- The stopwatch.stp sample script is now confirmed to work with the BPF =
backend:

=3D Examples of tested kernel versions=20

  2.6.32 (RHEL6 i686, x86_64)
  3.10.0 (RHEL7 x86_64)
  4.15.0 (Ubuntu 18.04 x86_64)
  4.18.0 (RHEL8 x86_64, aarch64, ppc64le, s390x)
  5.14.14 (Fedora 35 x86_64)
  5.14.16 (Fedora 34 x86_64)
  5.15.0-rc7  (Fedora rawhide x86_64)

=3D Known issues with this release

- There are known issues on kernel 5.10+ after adapting to set_fs()
  removal, with some memory accesses that previously returned valid data
  instead returning -EFAULT (see PR26811).

- An sdt probe cannot parse a parameter that uses a segment register.
  (PR13429)

- The presence of a line such as
      *CFLAGS +=3D $(call cc-option, -fno-var-tracking-assignments)
  in older linux kernel Makefile unnecessarily reduces debuginfo quality,
  consider removing that line if you build kernels.  Linux 5.10+ fixes t=
his.

=3D Contributors for this release

Aaron Merey, Alexandra H=C3=A1jkov=C3=A1*, Di Chen*, Du Zhe*, Frank Ch. =
Eigler
Junlong Li*, Nir Soffer*, Serhei Makarov, Sevan Janiyan*, Stan Cox
Sultan Alsawaf, Timm B=C3=A4der*, William Cohen

Special thanks to new contributors, marked with '*' above.

=3D Bugs fixed for this release <https://sourceware.org/PR#####>

6562     $SYSTEMTAP_DEBUGINFO_PATH does not work
15724     stapdyn looking for libdyninstAPI_RT.a
26839     Systemtap build failures with clang
27820     abort() tapset not implemented in the bpf mode
27829     support for floating point values passed through sdt.h markers
27864     loc2stap.cxx assertion failure on loc_unavailable type locatio=
n, rawhide
27881     failed to extend vma mapped entry when the address is adjacent
27903     handle f33 glibc $$parms
27932     List Python as a prerequisite in README
27933     Use of unitialized functioncall synthetic field in
27934     failure to attach statement
27940     The /* pc=3D0x... */ is no longer printed by "stap -v -L 'kern=
el.function("*")'
27942     testsuite/systemtap.base/perf.sh drop bashism
27984     stap skipping partially-inlined instance, but it is not inline=
 function actually
28070     extend vma end address to the different module
28079     adapt to kernel 5.14 task_struct.__state change
28084     autoconf-x86-uniregs.c compile failled with -Werror cause STAP=
CONF_X86_UNIREGS missing
28140     kernel panic on tracepoint activation in stap module
28184     task_fd_lookup failed on linux 5.11
28244     linux objtool imposes symbol length limits on generated functi=
on names
28384     finish nfs_proc tapset port 4.3 string server_ip
28443     Provide syscall_any tapset for bpf
28449     loss of cross-cpu output ordering
28544     procfs_bpf.exp regression due to string handling error=20
28557     module kprobe insertion on modern kernels
