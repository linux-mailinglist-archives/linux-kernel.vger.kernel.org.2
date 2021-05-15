Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 455C138161E
	for <lists+linux-kernel@lfdr.de>; Sat, 15 May 2021 07:26:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234365AbhEOF1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 May 2021 01:27:51 -0400
Received: from mail.efficios.com ([167.114.26.124]:39228 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234301AbhEOF1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 May 2021 01:27:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id B36A32BCB0A;
        Sat, 15 May 2021 01:26:26 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id EsxluEzGqOFd; Sat, 15 May 2021 01:26:24 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id 9D6EC2BCB07;
        Sat, 15 May 2021 01:26:24 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com 9D6EC2BCB07
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1621056384;
        bh=r5Ec6t4tIqJi7+VRh6KTPEpKnpfdkNAzUG4iOrqRtDI=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=X+gmSV4p52GOn6GFqSxUe/JsIRJvI69H5ouN00PVt9ZJKyaIBoFAx2PmAGwZTHb8F
         j2if+bsqNdsbxJ2oIxyV9szMVp9CPch8WcAVPu2nKLaXvip89aHm2yNFDtEIQSRmke
         DYNPckjG6W25qpSCSez508TOwwAOgEKMJJ4Sc8eG+rPExBoLAdoupw6VhbHw0FynfE
         yRhGfLGyPYKUs+gSTqzE7pJwdYXsu6sRTU4QcAXPH3t8WF09EyUkWt08KhGv2JdjKr
         JtUR1rS2GuH5ynlzeoCse7JY+9YcLKD1SoWJB7ZGWMXtm4tXDZJSBTsuKdhxeEEt3I
         b69d3DmCMnf8g==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id U214ZKN5NQl9; Sat, 15 May 2021 01:26:24 -0400 (EDT)
Received: from Mercury (unknown [107.159.88.171])
        by mail.efficios.com (Postfix) with ESMTPSA id 7C4022BCB06;
        Sat, 15 May 2021 01:26:24 -0400 (EDT)
Date:   Sat, 15 May 2021 01:26:24 -0400
From:   =?iso-8859-1?Q?J=E9r=E9mie?= Galarneau 
        <jeremie.galarneau@efficios.com>
To:     lttng-dev@lists.lttng.org
Cc:     diamon-discuss@lists.linuxfoundation.org,
        linux-trace-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RELEASE] LTTng =?iso-8859-1?Q?2=2E13=2E0-?=
 =?iso-8859-1?Q?rc2_-_Nordicit=E9?= - Linux kernel and user-space tracer
Message-ID: <YJ9bgH7uw24flNDD@Mercury>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

Today marks the release of the second LTTng 2.13 - Nordicit=E9 release ca=
ndidate.

A prettyfied version of this annoucement is available here:
https://github.com/lttng/lttng-tools/releases/tag/v2.13.0-rc2

If you were already testing the first release candidate of this release, =
please
note that LTTng-UST and LTTng-tools must be updated to "rc2" in locked-st=
ep
due to ABI changes. Also note that probe providers must be rebuilt agains=
t
LTTng-UST 2.13.0-rc2.

Have a look at the first release candidate's release notes for an
overview of the features introduced in LTTng 2.13.

https://github.com/lttng/lttng-tools/releases/tag/v2.13.0-rc1


What's new in LTTng-UST (Linux application tracer) 2.13.0-rc2?
---

- Allow explicit tracepoint instance provider name. Allow re-using a trac=
epoint
  class from tracepoint instances in other providers.

  This is a localized API-breaking change introduced very early in the
  2.13-rc cycle. The LTTNG_UST_TRACEPOINT_EVENT_INSTANCE macro newly intr=
oduced
  in LTTng-UST 2.13-rc1 now takes an extra "template_provider" argument.

  This changes the ABI exposed by the probe providers, so bump the probe
  provider major version, and make newer LTTng-UST reject old incompatibl=
e
  major.

  Probe providers built against LTTng-UST 2.13-rc1 must be rebuilt agains=
t
  LTTng-UST 2.13-rc2 to be traced.

- Add probe descriptor field to enumeration and event class

  Also breaks the ABI exposed by probe providers (provider major version =
already
  bumped for rc2). This enables additional validation of probe provider
  compatibility when using event class and enumerations across providers.

- Validate provider version for event class.

- Validate provider version for event enumeration field types.

- Introduce api0 and api1 compilation tests. This tests whether the API 0
  compatibility API works. See ust-api-compat.h for details.

- Fix Java (JUL and log4j) application context segmentation fault and lea=
ks.

- liblttng-ust-ctl: implement SIGBUS handling:

  This fixes a long-standing DoS where an unprivileged application could =
cause
  a SIGBUS in the consumer daemon by truncating the shared memory files i=
t
  receives from the session daemon. This requires that LTTng-tools be upg=
raded
  to 2.13-rc2 in locked-step with LTTng-UST 2.13-rc2.

- Restore communication protocol backward compatibility with LTTng-UST 2.=
12

  - liblttng-ust-ctl: keep using lttng-ust-sock-8 and lttng-ust-wait-8 fi=
lename

    LTTng-UST 2.13-rc1 erroneously changed the file names of those socket=
 and
    pipe files from [...]-8 to [...]-9, even though we intended to keep p=
rotocol
    compatibility between LTTng-UST 2.12 and LTTng-tools/ust 2.13. This c=
hanges
    reverts back to the prior filenames to make sure LTTng-UST 2.12 appli=
cations
    can be traced by a 2.13 LTTng-tools using 2.13 LTTng-UST.

  - Fix: add missing fields in struct lttng_ust_abi_channel_config

    Three fields were removed by mistake from this structure which is ABI
    between the consumer daemon and applications traced with LTTng-UST. A=
dd them
    back to allow tracing 2.12 LTTng-UST applications with a 2.13 LTTng-t=
ools
    using 2.13 LTTng-UST.

- Fix LTTng-UST communication protocol variable-length data handling

  When mixing older (e.g. 2.12) and newer versions of LTTng-UST talking t=
o each
  other between application and LTTng-tools, situations where commands ar=
e
  unknown lead to out-of-sync communication protocol.

  Change the protocol for commands new to LTTng-UST 2.13 so they acknowle=
dge the
  fixed-size commands before the variable-sized data is sent, so the
  communication protocol is kept in sync even when unknown command error
  happens. This also happens for more ancient commands released in prior
  versions for which we cannot change the protocol. Shutdown the socket f=
rom the
  session daemon side when we detect such errors, because there is no poi=
nt in
  trying to communicate further on an out-of-sync socket.

- Detect mixed liblttng-ust and liblttng-ust-tracepoint .so.0 and .so.1 l=
ibraries

  Detect and report with a new "critical" logging message whether .so.0 a=
nd
  .so.1 tracer libraries are loaded within a single process, which is an
  unsupported use-case. Note that the LTTNG_UST_DEBUG environment variabl=
e must
  be set to allow users to observe those critical messages.

  We also introduce a new LTTNG_UST_ABORT_ON_CRITICAL environment variabl=
e to
  allow the tracer to abort() the process whenever a critical logging sta=
tement
  is encountered. This is meant to facilitate discovering problematic
  deployments where an application indirectly loads different soname majo=
r
  numbers of LTTng-UST through its instrumented shared libraries.

See the ChangeLog for the full list of changes:
https://github.com/lttng/lttng-ust/blob/13861e2d/ChangeLog


What's new in LTTng-modules (Linux kernel tracer) 2.13.0-rc2?
---

- There are refactoring commits that were introduced after 2.13-rc1 to al=
ign the
  code of LTTng-modules with the refactoring that was done in LTTng-UST p=
rior to
  2.13-rc1. Given that LTTng-modules does not expose its kernel APIs to e=
xternal
  users, it was possible to do this refactoring even after rc1.

- Compiling the system call tracing code has typically been a resource-he=
avy
  endeavour both in terms of memory usage (~1G memory required) and CPU t=
ime. It
  has been split into smaller compile units to allow parallel compilation=
 and
  lessen the memory requirements on the compiler.

- Bitwise enumerations are now disabled by default. Only compiled in with=
 make
  CONFIG_LTTNG_EXPERIMENTAL_BITWISE_ENUM=3Dy.

- Fix: increment buffer offset when failing to copy from user-space.

- Implement ring buffer Pascal string copy: allows taking C-strings as in=
puts
  and record them to ctf_array_text and ctf_sequence_text fields (which a=
re
  Pascal strings) without causing out-of-bound reads of the C-strings of =
those
  are smaller than the size reserved for the pascal strings. This mirrors=
 the
  behaviour introduced in LTTng-UST 2.13-rc1.

- Support for 5.12 Linux kernels,

- Support recent stable kernel branches 4.14, 4.19, 5.4,

- Support for newer Ubuntu 4.15, 5.4, and RHEL 8.2/8.3 kernels,

See the ChangeLog for the full list of changes:
https://github.com/lttng/lttng-modules/blob/f982b51a/ChangeLog


What's new in LTTng-tools 2.13.0-rc2?
---

- The new features introduced in the 2.13 release are now fully documente=
d as
  part of the installed man pages. A number of improvements were also mad=
e to
  the existing documentation such as adding examples for the lttng-add-co=
ntext
  command.

- lttng client messages referring to "event rule hit" conditions have bee=
n
  changed to use the correct "event-rule matches" condition name.

- An example was added under doc/examples/trigger-condition-event-matches=
. It
  contains an application instrumented with LTTng-UST, a script that adds
  triggers to notify external clients whenever the application's events o=
ccur,
  and a notification client which consumes the resulting notification alo=
ng with
  any captured payload.

  See https://github.com/lttng/lttng-tools/tree/c3195dc0/doc/examples/tri=
gger-condition-event-matches#readme

- A bug resulting in the production of erroneous path hierarchies when a
  snapshot is streamed to a relay daemon was fixed. This bug resulted in
  duplicated domain names being present in the final path of a snapshot
  ("ust/ust" or "kernel/kernel") which could cause some automation script=
s to
  fail.

- A bug that caused some trace data to be invisible to live viewers has b=
een
  fixed.

  See https://lists.lttng.org/pipermail/lttng-dev/2021-May/029953.html

- A number of bugs that could result, under rare circumstances, in a hang=
 when
  using the lttng-clear command against a session that contains kernel ch=
annels
  was fixed.

- Miscellaneous stability improvements.

See the ChangeLog for the full list of changes:
https://github.com/lttng/lttng-tools/blob/4be5babe/ChangeLog


Links
---

Project website:
https://lttng.org

Download links:
https://lttng.org/files/lttng-tools/lttng-tools-2.13.0-rc2.tar.bz2
https://lttng.org/files/lttng-ust/lttng-ust-2.13.0-rc2.tar.bz2
https://lttng.org/files/lttng-modules/lttng-modules-2.13.0-rc2.tar.bz2

GPG signatures:
https://lttng.org/files/lttng-tools/lttng-tools-2.13.0-rc2.tar.bz2.asc
https://lttng.org/files/lttng-ust/lttng-ust-2.13.0-rc2.tar.bz2.asc
https://lttng.org/files/lttng-modules/lttng-modules-2.13.0-rc2.tar.bz2.as=
c
