Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23F12382F93
	for <lists+linux-kernel@lfdr.de>; Mon, 17 May 2021 16:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235507AbhEQOR5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 May 2021 10:17:57 -0400
Received: from mx2.suse.de ([195.135.220.15]:57360 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235543AbhEQOPN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 May 2021 10:15:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1621260836; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lwE+T0c+xlHjc49FEylrM2BvekW9eKLArf9QaPrjeEw=;
        b=MWgi0KHh0Jd9DgsygqlTrv7WF3mMH+tR979KiKRtH17JWUc0vjATnRHwRxkz7WqJdOap+b
        gDoh6thuXBQePPtv7wwg2NWmEnhuBeBhzRWG89YqvaBML/HVasdng0lVHp1Ff7jBJ4yMWg
        mOhDSclmEAjvafp9vOBWrPvrvpMt/nY=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 4BF45B231;
        Mon, 17 May 2021 14:13:56 +0000 (UTC)
Subject: Re: [PATCH v2 1/4] usb: early: Avoid using DbC if already enabled
To:     Connor Davis <connojdavis@gmail.com>
Cc:     Jann Horn <jannh@google.com>, Lee Jones <lee.jones@linaro.org>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        xen-devel@lists.xenproject.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <cover.1620950220.git.connojdavis@gmail.com>
 <d160cee9b61c0ec41c2cd5ff9b4e107011d39d8c.1620952511.git.connojdavis@gmail.com>
 <8ccce25a-e3ca-cb30-f6a3-f9243a85a49b@suse.com>
 <16400ee4-4406-8b26-10c0-a423b2b1fed0@gmail.com>
From:   Jan Beulich <jbeulich@suse.com>
Message-ID: <ddb58cbd-0a72-f680-80f4-ce09b13a2cee@suse.com>
Date:   Mon, 17 May 2021 16:13:55 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <16400ee4-4406-8b26-10c0-a423b2b1fed0@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.05.2021 15:48, Connor Davis wrote:
> 
> On 5/17/21 3:32 AM, Jan Beulich wrote:
>> On 14.05.2021 02:56, Connor Davis wrote:
>>> Check if the debug capability is enabled in early_xdbc_parse_parameter,
>>> and if it is, return with an error. This avoids collisions with whatever
>>> enabled the DbC prior to linux starting.
>> Doesn't this go too far and prevent use even if firmware (perhaps
>> mistakenly) left it enabled?
> 
> Yes, but how is one supposed to distinguish the broken firmware and 
> non-broken
> 
> firmware cases?

Well, a first step might be to only check if running virtualized.
And then if your running virtualized, there might be a way to
inquire the hypervisor?

Jan
