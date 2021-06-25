Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3A7B3B3AA1
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Jun 2021 03:54:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232992AbhFYB42 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Jun 2021 21:56:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232917AbhFYB41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Jun 2021 21:56:27 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98133C061574
        for <linux-kernel@vger.kernel.org>; Thu, 24 Jun 2021 18:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:
        Subject:Sender:Reply-To:Content-ID:Content-Description;
        bh=X8kmuSqklf87h0pKfcyRyBJozjhEjI8e85R3dlzwnEM=; b=GkaoiSB40JuyWkeP8HVfUrU5KG
        vfqWbnx8l3rjebZuCwqCBFaWCJJrCXuqCAH6KPO2llk3+4T8hpCQWjJTpgw5bR0bmJXOqUp7W+fNm
        556G8Wol3r+h8P0i4cAM6Fxjsv3t3hPR/0sRPUH7lUQdC6rBd1BiZ6MgOWNzgVpl2CjLG0Y7TYWsd
        JMq7dc1UoWAW22gK2fEPXV3Kc4AcRLHFr+HqSGf0OnpuUL4EsbRJso6PwybZj7dEbwbioyGIfI96Q
        hYYycyHlbt7AGOXzB/gOOOPu+UU+AITMQQJGk5eSjHtz0CyK7HQECb3S66QQghUH9IotR8p5HL8qf
        4dBotb/g==;
Received: from [2601:1c0:6280:3f0::aefb]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwb2Z-00H4MY-3U; Fri, 25 Jun 2021 01:53:55 +0000
Subject: Re: [RFC] reconsider [PATCH] hostname up to 255 character
To:     Matt Hardcastle <m@hardcastle.com>, linux-kernel@vger.kernel.org
References: <A27A5542-69CD-4B7F-86C5-6940179988B0@hardcastle.com>
Cc:     "Eric W. Biederman" <ebiederm@xmission.com>, drepper@redhat.com,
        Jan-Benedict Glaw <jbglaw@lug-owl.de>,
        Jan Engelhardt <jengelh@linux01.gwdg.de>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <7f5cbd89-7008-7da7-2329-8b91753a02d1@infradead.org>
Date:   Thu, 24 Jun 2021 18:53:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <A27A5542-69CD-4B7F-86C5-6940179988B0@hardcastle.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/23/21 12:16 PM, Matt Hardcastle wrote:
> Hi,
> 
> In 2006 Randy Dunlap submitted a patch [^1] to increase the supported hostname length to 255 characters. There was some discussion on the patch, but it appeared to go stale.
> 
> Are you open to reconsidering the change?
> 
> - m@
> 
> ^1 https://lore.kernel.org/lkml/20060525204534.4068e730.rdunlap@xenotime.net/
> 

Hi,

Thanks for bringing this back up.  Very few people read/reply to LKML unless
they are Cc-ed on the email, so I'll add a few Cc's here.


-- 
~Randy

