Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 724E23FE9DA
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 09:17:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243220AbhIBHR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 03:17:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41898 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234401AbhIBHRv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 03:17:51 -0400
Date:   Thu, 2 Sep 2021 09:16:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630567011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7OxyCv2/Ddgx87zBUXmo/5P1iUdhcowedctISPLnNYc=;
        b=0/7uI6TgWqLSj/Mg1ScvDaN5Hb+Yk3Q968soKgf7z6o72CvoZzrNOybWKpWhWrPBsZOCF2
        VZS1Wocq9uEeYZNK0od0FP0aLHw7SIofovTUZexslzaMDjLdnQn3U/vdKFU0CvJbWbz+HF
        08ye6M8XxFk6R2RWpmEWfzRnEqXy/Ha5YgmeCJ4BevznbY5gWmKH0kX9euElGvKh11j/ym
        tBSiilNdKIa65xkMgfcJUyo3CYp6/6YFbBaTGbD92GXY3rbPzx67YGG+0pybqaQ73DjPbK
        4UrU6d0LTC2Qc0iFRqUJv0CpBzfDAKk7943299B6ZzcJ7pZPla6HO5F2Zd1rzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630567011;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7OxyCv2/Ddgx87zBUXmo/5P1iUdhcowedctISPLnNYc=;
        b=xOD9dm6BkHFkgzPREpcX9KTBGRFdFNV5yYnCjID7bSuEYd+tgc3iUCJH0Itcs8RSg/DTE1
        oqALR3n1ZUvVLSBQ==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v2] trace: Add migrate-disabled counter to tracing output.
Message-ID: <20210902071650.azcpx6nzjox3ymxe@linutronix.de>
References: <20210806164907.xtgvrb25eb4isxhd@linutronix.de>
 <20210806135124.1279fc94@oasis.local.home>
 <20210810132625.ylssabmsrkygokuv@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210810132625.ylssabmsrkygokuv@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-08-10 15:26:26 [+0200], To Steven Rostedt wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
>=20
> migrate_disable() forbids task migration to another CPU. It is available
> since v5.11 and has already users such as highmem or BPF. It is useful
> to observe this task state in tracing which already has other states
> like the preemption counter.
>=20
> Instead of adding the migrate disable counter as a new entry to struct
> trace_entry, which would extend the whole struct by four bytes, it is
> squashed into the preempt-disable counter. The lower four bits represent
> the preemption counter, the upper four bits represent the migrate
> disable counter. Both counter shouldn't exceed 15 but if they do, there
> is a safety net which caps the value at 15.
>=20
> Add the migrate-disable counter to the trace entry so it shows up in the
> trace. Due to the users mentioned above, it is already possible to
> observe it:
>=20
> |  bash-1108    [000] ...21    73.950578: rss_stat: mm_id=3D2213312838 cu=
rr=3D0 type=3DMM_ANONPAGES size=3D8192B
> |  bash-1108    [000] d..31    73.951222: irq_disable: caller=3Dflush_tlb=
_mm_range+0x115/0x130 parent=3Dptep_clear_flush+0x42/0x50
> |  bash-1108    [000] d..31    73.951222: tlb_flush: pages:1 reason:local=
 mm shootdown (3)
>=20
> The last value is the migrate-disable counter.
>=20
> Things that popped up:
> - trace_print_lat_context() does not print the migrate counter. Not sure
>   if it should. It is used in "verbose" mode and uses 8 digits and I'm
>   not sure ther is something processing the value.
>=20
> - trace_define_common_fields() now defines a different variable. This
>   probably breaks things. No ide what to do in order to preserve the old
>   behaviour. Since this is used as a filter it should be split somehow
>   to be able to match both nibbles here.
>=20
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> [bigeasy: patch description.]
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> v1=E2=80=A6v2:
>   - use the upper nibble of the preemption counter for the migrate
>     disable counter and the lower for the preemption counter. This
>     avoids extending the struct by four bytes due to alignment /
>     padding.
=20
 Ping.

Sebastian
