Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7004E44DC20
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Nov 2021 20:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234484AbhKKTXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Nov 2021 14:23:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231741AbhKKTXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Nov 2021 14:23:12 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4929C061766
        for <linux-kernel@vger.kernel.org>; Thu, 11 Nov 2021 11:20:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=hVNK8a+gPPIOzXSAh7hr6MuCVSQAU9SjjqAmXCwCWvk=; b=YzlRxPzSMeOCuXLIjePOBfLkac
        FSpkH70Ob1L5fXDHrJ3eKgQwZesNYQsjYkRegg8B7La0PjJ8MZbYGvNik6GaUIyNmZyzqSeckh2hm
        tjtXRGqVm1EY/w3bstur/ZlRIXgH317Ul5Q2HKLoPUs1BmdZfE9h0HlcUOsHlHndP9GH0y6C/bt3F
        Ij8iea7MATw6EWtVRgVydERpPFD/y1gIxPw8ul7eGAmrOYtjvO4TW0k9xK3iDXezx8h6w4s4X8MQx
        hZcpxDomNl+DwnqYHIuF+t2TOvpdGh5GiybWw0wB+RBm+iZ0uFaHFVvCWT/Pocy9vgd8jZhI965wE
        QgfEjI3g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mlFcK-00FVwT-BT; Thu, 11 Nov 2021 19:20:12 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C1E5E3000DD;
        Thu, 11 Nov 2021 20:20:10 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AB4F42CAFBBB9; Thu, 11 Nov 2021 20:20:10 +0100 (CET)
Date:   Thu, 11 Nov 2021 20:20:10 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Waiman Long <longman@redhat.com>
Cc:     Hillf Danton <hdanton@sina.com>,
        =?utf-8?B?6ams5oyv5Y2O?= <mazhenhua@xiaomi.com>,
        mingo <mingo@redhat.com>, will <will@kernel.org>,
        "boqun.feng" <boqun.feng@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG]locking/rwsem: only clean RWSEM_FLAG_HANDOFF when already
 set
Message-ID: <YY1s6v9b/tYtNnGv@hirez.programming.kicks-ass.net>
References: <4fafad133b074f279dbab1aa3642e23f@xiaomi.com>
 <20211107090131.1535-1-hdanton@sina.com>
 <13d683ed-793c-b502-44ff-f28114d9386b@redhat.com>
 <02e118c0-2116-b806-2b48-b9c91dc847dd@redhat.com>
 <20211110213854.GE174703@worktop.programming.kicks-ass.net>
 <YY0x55wxO2v5HCOW@hirez.programming.kicks-ass.net>
 <61735528-141c-8d77-592d-b6b8fb75ebaa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <61735528-141c-8d77-592d-b6b8fb75ebaa@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 11, 2021 at 02:14:48PM -0500, Waiman Long wrote:
> As for the PHASE_CHANGE name, we have to be consistent in both rwsem and
> mutex. Maybe a follow up patch if you think we should change the
> terminology.

Well, that's exactly the point, they do radically different things.
Having the same name for two different things is confusing.

Anyway, let me go read that patch you sent.
