Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68BB53FF46F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Sep 2021 21:56:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244551AbhIBT4v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Sep 2021 15:56:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231770AbhIBT4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Sep 2021 15:56:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F13C061575
        for <linux-kernel@vger.kernel.org>; Thu,  2 Sep 2021 12:55:45 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1630612543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bPsaQodBBaPXjBpLhlMKD2QE/aFgfvkyaqt6begb7JI=;
        b=szk8IM0wEdru4Yfs08MaYrr+3H+nSkNlR4+rmbGYzVUW4sUZskcQNt8yyh4DSwqHvtj+6u
        kJpUpwq10m/6WoADR43JfiVpS+dEC/PZursF4oeN9XbxdQA12d0l55NliH6A41j4NPsS19
        Vqt37jAnAVGLtdwBwKGKqTpxjmzv4BuaIwhsAsGW7ijWpDU7l3p4dM0HAgCoCsHVBRK3jg
        nMPkSDI7zLmfn1lilt/i6wrh+DADmtljivU8S7xbnehlNrNwSgdwAgfoa3qac6aIDqw8+h
        umC7ThmSDTIcs7LM+NGqx9ogBpYvKXqXv9Yq1RadkVroBWUWGdQx6NDSuLugnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1630612543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bPsaQodBBaPXjBpLhlMKD2QE/aFgfvkyaqt6begb7JI=;
        b=baE+Xdp0W5qmAQqeEmxsXY91+h916kZVMQrUY0QsiFvidmS8m9f6yBSY0HujDRLI913PzT
        pLS7b6+tjehLPjAg==
To:     Jens Axboe <axboe@kernel.dk>, Matthew Wilcox <willy@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Linux Memory Management List <linux-mm@kvack.org>
Subject: Re: slub: BUG: Invalid wait context
In-Reply-To: <4b884d2b-bcac-4967-d792-f7653084c38d@kernel.dk>
References: <3b7661a1-dbde-ea54-f880-99777c95ae22@kernel.dk>
 <YTEeTK83KNBmuJLC@casper.infradead.org>
 <91af18d0-64cb-71ac-e9f4-4135fe02cb33@kernel.dk>
 <YTEf2MEkEdMVAuRF@casper.infradead.org>
 <4b884d2b-bcac-4967-d792-f7653084c38d@kernel.dk>
Date:   Thu, 02 Sep 2021 21:55:42 +0200
Message-ID: <87r1e6bvlt.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 02 2021 at 13:05, Jens Axboe wrote:
> On 9/2/21 1:02 PM, Matthew Wilcox wrote:
>>          NOTE: There are known nesting problems. So if you enable this
>>          option expect lockdep splats until these problems have been fully
>>          addressed which is work in progress. This config switch allows to
>>          identify and analyze these problems. It will be removed and the
>>          check permanently enabled once the main issues have been fixed.
>> 
>>          If unsure, select N.
>
> This isn't a new text, it's been like that for quite a while. The warning
> is new on -git with that option.

I'm looking into it...
