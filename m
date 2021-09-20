Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8BC041121B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Sep 2021 11:50:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236352AbhITJwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Sep 2021 05:52:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41096 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236318AbhITJwU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Sep 2021 05:52:20 -0400
Date:   Mon, 20 Sep 2021 11:50:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1632131452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZxRILvmjy4ooem4+55x6inqqVZExJI1xLe5CwsVk4v4=;
        b=gOd6OlzPDNCajZ+32myWCg2wYu3w21lCutte84ROb/FOsjFZE6x3ncfuZkixA3zJSDzHnk
        9syY/I+Jc2sMgt1MRKh+2e7ESUStjvrCFkh7kfWacwalbc/9oA8JyZqY+lKQUgTyxahRzZ
        ozQEJ3aoEH/vVdSalxs94V8P1E12fH4vOgrqI3pI5BZKxydQ3SenJocOIv5d+6V8Dsb0lq
        mJjUYTRP9yV6Sb8SkVZZQ1T77HUhrLXX659Zk1bCAuTtkKk2sp9/5m1I0gMc8wtnbrn7DG
        Snh3h/oVF8P2+S6WdWz7jcJMnqiSimaq3XRc2C75QJlSvPiPUiNip4jxe7fAOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1632131452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ZxRILvmjy4ooem4+55x6inqqVZExJI1xLe5CwsVk4v4=;
        b=TY44NoVOe1Rq68D7VstjIz8qk1FNu/GhDQGOLkYLNQwpUNJrRdLS8GZ73dVSLRkT+JBidV
        jUwarTmstRpnszCg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Marco Elver <elver@google.com>
Cc:     kasan-dev@googlegroups.com, linux-kernel@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Clark Williams <williams@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 0/5] kcov: PREEMPT_RT fixup + misc
Message-ID: <20210920095051.uaukljr5axkv4ctq@linutronix.de>
References: <20210830172627.267989-1-bigeasy@linutronix.de>
 <CANpmjNPZMVkr5BpywHTY_m+ndLTeWrMLTog=yGG=VLg_miqUvQ@mail.gmail.com>
 <20210906162824.3s7tmdqah5i7jnou@linutronix.de>
 <CANpmjNPn5rS7MyoDtzJNbs9Gxo=26H_z7CX4UDQcwLRtJfZa6A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CANpmjNPn5rS7MyoDtzJNbs9Gxo=26H_z7CX4UDQcwLRtJfZa6A@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-20 11:26:38 [+0200], Marco Elver wrote:
> I saw Dmitry responded with Acks/comment. Did you have a tree in mind
> to take it through? Usually KCOV changes go through the -mm tree, in
> which case please Cc Andrew in the rest of the series.

Okay. In that case I'm going to repost it with all the tags and akpm in
Cc:.

> Thanks,
> -- Marco

Sebastian
