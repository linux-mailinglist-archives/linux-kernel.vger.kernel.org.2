Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54D0130AF21
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Feb 2021 19:25:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230214AbhBASZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Feb 2021 13:25:04 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59150 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbhBASYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Feb 2021 13:24:30 -0500
Date:   Mon, 1 Feb 2021 19:23:45 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612203826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wH3hRYmq1SCoI7lMjqUcYsC9IWKGNlYWwvJVHB/i1hQ=;
        b=H2KVS91+QqqnLVWoY0zqyahaynnBlf0s8dXj+AxZe025VfE9sx15FpFqPCYbsdqREdlq/a
        DyJwRUufL+WTt+xbbkgEB3PwlsnLiST1+acQsBwUgEc6IxF/vsclguMOAWVEAUs7vej9gM
        pcXW2lIkve+v6JhskbNHOp+rg7w3FJ8QStudAgG3S7/nVxUFQnDhwFQaakPbo7vK0rr1k7
        0ysznf1MMOa9ZWFV+Ivt0/IH43USxZk7ZcvF5siVLm+jIZvOCUCujEh3g9begTKB25Ue6N
        DjwGXM9IFEK/h99T5oNhIlzYFlv57Pt14ae4xFGWgcLiAQS0iJ9b3Jwyrj5bUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612203826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wH3hRYmq1SCoI7lMjqUcYsC9IWKGNlYWwvJVHB/i1hQ=;
        b=cv3mwMrrJaGjx4YpSmTqLPDJzi35FhoDAChHwttP09biCOgcwHKp1RwfGWVLAno8eo/Bvu
        kkFo1aZpJ0YgWkCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: [PATCH 0/4 v2] tracing: Merge irqflags + preempt counter.
Message-ID: <20210201182345.xcdcxxpa2bysbgzc@linutronix.de>
References: <20210125140323.6b1ff20c@gandalf.local.home>
 <20210125194511.3924915-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20210125194511.3924915-1-bigeasy@linutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-01-25 20:45:07 [+0100], To linux-kernel@vger.kernel.org wrote:
> The merge irqflags + preempt counter, v2.
>=20
> v1=E2=80=A6v2:
>  - Helper functions renamed.
>  - Added patch #2 which inlines the helper functions.
>=20

a gentle ping.

Sebastian
