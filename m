Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1CAB640E823
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 20:00:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349417AbhIPRiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 13:38:07 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:51006 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352842AbhIPR3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 13:29:00 -0400
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 4D71F222B1;
        Thu, 16 Sep 2021 17:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1631813258; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cvK4RXBYn91QzdGRQO8ETT/MbJS108gNvDV2Bm77VSw=;
        b=g2cR74dM9mV8sBHPclIkqNNYBdjiXRKZTeZkNhlFViio+LdIN+sGa6Enltu5AmfLlie/Kp
        VkjOTxmmuWL2FJNMttZjG+t9JZb/jb04ulYKViftq1bD3GLRLfO6NS/D3QmKbTREr03CVN
        CwfT2tCvT8v2F/dZpgbLP9IaKcePfn8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1631813258;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cvK4RXBYn91QzdGRQO8ETT/MbJS108gNvDV2Bm77VSw=;
        b=8EHMhJYjXkmUAIMHP5WKT1tSzgu2ioOa1afxMEA/W27p55GSj4vTR3LQckKJmzklRyDxM6
        vcBFgLPcuCxSzjCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 3A51413D5A;
        Thu, 16 Sep 2021 17:27:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wGkADop+Q2ETZQAAMHmgww
        (envelope-from <dbueso@suse.de>); Thu, 16 Sep 2021 17:27:38 +0000
MIME-Version: 1.0
Date:   Thu, 16 Sep 2021 10:27:37 -0700
From:   Davidlohr Bueso <dbueso@suse.de>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Davidlohr Bueso <dave@stgolabs.net>, peterz@infradead.org,
        mingo@kernel.org, rostedt@goodmis.org, longman@redhat.com,
        boqun.feng@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] locking/rwbase_rt: Lockless reader waking up a writer
In-Reply-To: <20210916170223.ocefifs33ul6lx6h@linutronix.de>
References: <20210901222825.6313-1-dave@stgolabs.net>
 <20210901222825.6313-3-dave@stgolabs.net> <87ilz4fyzi.ffs@tglx>
 <87wnnjcuam.ffs@tglx> <20210916170223.ocefifs33ul6lx6h@linutronix.de>
User-Agent: Roundcube Webmail
Message-ID: <266c7b13b614e45b5d01747b1ac70eb1@suse.de>
X-Sender: dbueso@suse.de
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-09-16 10:02, Sebastian Andrzej Siewior wrote:
> On 2021-09-14 12:42:41 [+0200], Thomas Gleixner wrote:
>> Something like the untested below should work.
> 
> works.

Works for me too. Also survived an overnight round of mmap_sem pounding 
on v5.14-rt.

Thanks,
Davidlohr
