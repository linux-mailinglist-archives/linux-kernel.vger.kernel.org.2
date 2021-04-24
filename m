Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 702EF369E70
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Apr 2021 03:55:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236779AbhDXB4E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Apr 2021 21:56:04 -0400
Received: from mail.efficios.com ([167.114.26.124]:44738 "EHLO
        mail.efficios.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbhDXBz6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Apr 2021 21:55:58 -0400
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id E42E732F025;
        Fri, 23 Apr 2021 21:55:20 -0400 (EDT)
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id R7JC3_cj1W5k; Fri, 23 Apr 2021 21:55:19 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.efficios.com (Postfix) with ESMTP id C7E6D32EF47;
        Fri, 23 Apr 2021 21:55:19 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.efficios.com C7E6D32EF47
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=efficios.com;
        s=default; t=1619229319;
        bh=VlmtgdbUd94TPeyqFTReqSYBU5SCJlnb+HLl6vZhrEw=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=kKj3JxnifIsV9yT1e4rW4iDb8kkkXR8uTh245Iq45q2SC42Phd7ivt2XmxpAmHoT4
         oylAlr+tcp8D5DlgufM1Ixk7Ifkf4AmGkPMpRrOrErKUY+RhrjQb0ixZpT1iqacFeW
         SKDCQAvlPZABar5WjJI+EhPXz07Z/shWCc5dmtuUE3+LO201ZDEzem8VPYNITINjJ3
         a7i+qvtSKMVqGqgHQ2sK0ubMMnaaxkYYp+sC43PzzG733vZxvDd4YlFxUMN3kITm5B
         /xbqZ8CnQGLrC5HUAlZDL4rwJ8SvNiN+AetPW9cSrOanE0VkNNSxeR4u8ql1SdMtcL
         VfaAo/13+3ifg==
X-Virus-Scanned: amavisd-new at efficios.com
Received: from mail.efficios.com ([127.0.0.1])
        by localhost (mail03.efficios.com [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Rj4XBSsRuT2e; Fri, 23 Apr 2021 21:55:19 -0400 (EDT)
Received: from mail03.efficios.com (mail03.efficios.com [167.114.26.124])
        by mail.efficios.com (Postfix) with ESMTP id AF30B32EFB6;
        Fri, 23 Apr 2021 21:55:19 -0400 (EDT)
Date:   Fri, 23 Apr 2021 21:55:19 -0400 (EDT)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     lttng-dev <lttng-dev@lists.lttng.org>
Cc:     Jeremie Galarneau <jgalar@efficios.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Diamon discuss <diamon-discuss@lists.linuxfoundation.org>,
        linux-trace-users <linux-trace-users@vger.kernel.org>,
        lwn <lwn@lwn.net>
Message-ID: <1127798495.12500.1619229319588.JavaMail.zimbra@efficios.com>
Subject: =?utf-8?Q?[RELEASE]_LTTng_2.13.0-rc1_-_Nordicit?=
 =?utf-8?Q?=C3=A9_-_Linux_kernel_and_user-space_tracer?=
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [167.114.26.124]
X-Mailer: Zimbra 8.8.15_GA_4018 (ZimbraWebClient - FF87 (Linux)/8.8.15_GA_4007)
Thread-Index: CU6heiwyyqEgTIkZQRbJAX32k/C24Q==
Thread-Topic: LTTng 2.13.0-rc1 - =?utf-8?Q?Nordicit=C3=A9?= - Linux kernel and user-space tracer
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,
 =20
Today we are releasing the first release candidate of LTTng 2.13 - Nordicit=
=C3=A9!
This release is the result of 1 year of development from most of the Effici=
OS
team.

This release is named after "Nordicit=C3=A9", the product of a collaboratio=
n between
Champ Libre and Bor=C3=A9ale. This farmhouse IPA is brewed with Kveik yeast=
 and
Qu=C3=A9bec-grown barley, oats and juniper branches. The result is a remark=
able
fruity hazy golden IPA that offers a balanced touch of resinous and woodsy
bitterness.

The most notable features of this new release are:
  - Event-rule matches condition triggers and new actions,
  - Notification payload capture,
  - vtracef and vtracelog (LTTng-UST),
  - Add user space time namespace context (LTTng-UST and LTTng-modules).

Read on for a short description of each of the new features and the
links to this release.

A prettified version of this announcement will be available soon on GitHub:
https://github.com/lttng/lttng-tools/releases/tag/v2.13.0-rc1


Note on LTTng-UST backward compatibility
---

- soname major version change
  This release changes the LTTng-UST soname major from 0 to 1.

  The event notifier (triggers using an event-rule-matches condition)
  functionality required a significant rework of public data structures whi=
ch
  should never have been made public in the first place.

  Bumping the soname major to 1, will require applications and tracepoint
  providers to be rebuilt against an updated LTTng-UST to use it.

  Old applications and tracepoint providers linked against libraries with
  major soname 0 should be able to co-exist on the same system.

- Building probe providers using a C++ compiler requires C++11

- API namespaceing
  The LTTng-UST API is now systematically namespaced under `lttng_ust_*` (e=
.g
  `tracepoint()` becomes `lttng_ust_tracepoint()`).

  However, the non-namespaced names are still exposed to maintain API
  compatibility.


Event-rule matches condition and new actions
---

Expanding the trigger infrastructure and making it usable through the `lttn=
g`
client was the core focus of this release.

A trigger is an association between a condition and one or more actions. Wh=
en
the condition associated to a trigger is met, the actions associated to tha=
t
trigger are executed. The tracing does not have to be active for the condit=
ions
to be met, and triggers are independent from tracing sessions.

Since their introduction as part of LTTng 2.10, new conditions and actions =
were
added to make this little-known mechanism more flexible.

For instance, before this release, triggers supported the following conditi=
on
types:
  - Buffer usage exceeded a given threshold,
  - Buffer usage went under a configurable threshold,
  - A session rotation occurred,
  - A session rotation completed.

A _notify_ action could be used to send a notification to a third party
applications whenever those conditions were met.

This made it possible, for instance, to disable certain event rules if the
tracing buffers were almost full. It could also be used to wait for session
rotations to be completed to start processing the resulting trace chunk
archives as part of various post-processing trace analyses.

This release introduces a new powerful condition type: event-rule matches.

This type of condition is met when the tracer encounters an event matching =
the
given even rule. The arguments describing the event rule are the same as th=
ose
describing the event rules of the `enable-event` command.

While this is not intended as a general replacement for the existing
high-throughput tracing facilities, this makes it possible for an applicati=
on
to wait for a very-specific event to occur and take action whenever it occu=
rs.
The purpose of event-rule matches triggers is to react quickly to an event
without the delay introduced by buffering.

For example, the following command will create a trigger that emits a
notification whenever the 'openat' system call is invoked with the
'/etc/passwd' filename argument.

$ lttng add-trigger
    --condition event-rule-matches
      --domain=3Dkernel
      --type=3Dsyscall
      --name=3D"openat"
    --action notify

New actions were also introduced as part of this release:
  - Start session
    This action causes the LTTng session daemon to start tracing for the se=
ssion
    with the given name. If no session with the given name exist at the tim=
e the
    condition is met, nothing is done.

  - Stop session
    This action causes the LTTng session daemon to stop tracing for the ses=
sion
    with the given name. If no session with the given name exist at the tim=
e the
    condition is met, nothing is done.

  - Rotate session
    This action causes the LTTng session daemon to rotate the session with =
the
    given name. See lttng-rotate(1) for more information about the session
    rotation concept. If no session with the given name exist at the time t=
he
    condition is met, nothing is done.

  - Snapshot session
    This action causes the LTTng session daemon to take a snapshot of the
    session with the given name. See lttng-snapshot(1) for more information
    about the session snapshot concept. If no session with the given name e=
xist
    at the time the condition is met, nothing is done.

These new actions can also be combined together. For instance, the followin=
g
trigger will stop `my_session`, record a snapshot of `my_session`, and noti=
fy
any listening application when '/etc/passwd' is opened:

$ lttng add-trigger
    --condition event-rule-matches
      --domain kernel
      --type syscall
      --name "openat"
      --filter 'filename =3D=3D "/etc/passwd"'
    --action stop-session my_session
    --action snapshot-session my_session
    --action notify

For more information, see the following manual pages:
  - lttng-add-trigger(1),
  - lttng-remove-trigger(1),
  - lttng-list-triggers(1).


Notification payload capture
---

The new event-rule matches condition type also allows 'captures'.
This allow event record and context fields to be captured when an event-rul=
e
matches condition is satisfied.

The captured field values are made available in the evaluation object of th=
e
notifications transmitted to listening applications.

Capture descriptors can be specified using a syntax reminiscent of the one =
used
by the filter expressions.

The following example will capture a process's name and the 'filename' argu=
ment
of all `openat()` system calls:

$ lttng add-trigger
    --condition event-rule-matches
      --domain kernel
      --type syscall
      --name "openat"
      --capture "filename"
      --capture "$ctx.procname"
    --action notify

See the lttng-add-trigger(1) manual page for more information.


vtracef and vtracelog (LTTng-UST)
---

New versions of the `tracef()` and `tracelog()` tracing helpers accepting
variable argument lists are introduced as `vtracef()` and `vtracelog()`.

See the tracef(3) and tracelog(3) manual pages for more information.


Add time namespace context (LTTng-UST and LTTng-modules)
---

It is now possible to add the time namespace of a process as a context to
channels (`time_ns`) using the `add-context` command.

See the time_namespaces(7) manual page for more information.


Links
---

Project website: https://lttng.org

Download links:
https://lttng.org/files/lttng-tools/lttng-tools-2.13.0-rc1.tar.bz2
https://lttng.org/files/lttng-ust/lttng-ust-2.13.0-rc1.tar.bz2
https://lttng.org/files/lttng-modules/lttng-modules-2.13.0-rc1.tar.bz2

GPG signatures:
https://lttng.org/files/lttng-tools/lttng-tools-2.13.0-rc1.tar.bz2.asc
https://lttng.org/files/lttng-ust/lttng-ust-2.13.0-rc1.tar.bz2.asc
https://lttng.org/files/lttng-modules/lttng-modules-2.13.0-rc1.tar.bz2.asc

--=20
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
