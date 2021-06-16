Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5902E3AA065
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Jun 2021 17:50:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234722AbhFPPwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Jun 2021 11:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234419AbhFPPw1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Jun 2021 11:52:27 -0400
Received: from mail-qk1-x72c.google.com (mail-qk1-x72c.google.com [IPv6:2607:f8b0:4864:20::72c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD1AAC061574
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 08:50:20 -0700 (PDT)
Received: by mail-qk1-x72c.google.com with SMTP id i68so3132384qke.3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Jun 2021 08:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AsjyCLXtk4zgDh+YABFD3KpRolDt1Xukeuq6QPAS+d0=;
        b=gvw0eVg2NYxhYI1Qg0P3VNTbU6oH4g7iS2sH22dWZcyNzQR12eoxanTqnRa4no4Li0
         hkZMDxtuh5mb1b873IA/mOLl4gzpGybk+rqDzSWCCKVLwsdyOqq1WQkpkR8DhKaKl3zC
         m0oO1hX4r6IEomgksPuMX6FyKHry282hkcbJq4AqzZH95092IbvRe8OQtt1dhzQAJ/wZ
         634PJH8zCy/VeN2mZ+U8n39xaNLFDZMLZRJrvCpMatNmNMlcTTmJKbvqvCZbU8aNWWPg
         N3VePqPLQjAhBjf0RY+Bw3dxLB0Khmj21W6lbgmQ05IdHTdsevBbl2bxXKV59idIOx2A
         qEJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=AsjyCLXtk4zgDh+YABFD3KpRolDt1Xukeuq6QPAS+d0=;
        b=uWv0lC/zgNDW6aTZKDENi/kz+bcuzkQTFe+LckIvQjS1TGG/AHcuH+nAV3JNR8BNWS
         s8/rihSHTEX7eif9TZOUgknOlL+pYF6KZYV0zUtS/1iIjDeIzVXZXyNZ+QAyo0mE8uEy
         rSw8Z+reDTq4MhyZkxk+JZLZ1DYn1nop0W1OLDQQ8gsunsCWOUOydm6fikp5AUnuEKsF
         ibTVug0VfU7DpN2ja4/0AgjC3BfUpwFckDeDQC7gzcTflmP1rNRr/Po98LPe9bS4YEle
         nI74K7/0Y4JfIwRNW/uc3Hbv0VqY2AiYj2eMlEuB0E0iQchLac47ejSseHEeueuKvh4e
         DCJw==
X-Gm-Message-State: AOAM533oN4sQSpwbiPONdcxJ6sCLtfTwO01Gh2P/FRCfDqT0xTAJFjD4
        t7JzZ79BJM0+kPUJDeNfK80=
X-Google-Smtp-Source: ABdhPJxLR5t4bB+NU8XyhLvLs6dpfTjsl/g2RkzcUIaAXQFWQxUjMfq01lJ8VYyJnBZ2i23E8PmhzQ==
X-Received: by 2002:a37:b17:: with SMTP id 23mr754236qkl.60.1623858619844;
        Wed, 16 Jun 2021 08:50:19 -0700 (PDT)
Received: from localhost ([199.192.137.73])
        by smtp.gmail.com with ESMTPSA id p145sm1875964qka.13.2021.06.16.08.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Jun 2021 08:50:19 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 16 Jun 2021 11:50:18 -0400
From:   Tejun Heo <tj@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Can we get a general timed LRU built on the workqueue subsys?
Message-ID: <YModuoRpG47DSaXG@slm.duckdns.org>
References: <485281.1623165261@warthog.procyon.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <485281.1623165261@warthog.procyon.org.uk>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, David.

On Tue, Jun 08, 2021 at 04:14:21PM +0100, David Howells wrote:
> Would it be practical to get some sort of timed LRU built on top of the
> workqueue such that I can, say, queue an item on it without using the
> delayed_work struct?
> 
> The reason I'd like this is that I want to avoid using delayed_work because it
> would increase the size of the fscache_cookie struct by 50% (110% with
> lockdep), and then you'd have to multiply that by the number of cookies on the
> system - could be tens or hundreds of thousands; could be a million+ in some
> applications.
> 
> Really, only one timer should be necessary for the entire queue if every item
> in the queue has the same timeout length, since it would only need to keep
> track of the item at the front of the queue.  This timer could be managed with
> timer_reduce() rather than mod_timer() or del_timer()+add_timer().
> 
> Each item in the queue would need a timestamp to say when it expires, say:
> 
> 	struct work_lru {
> 		struct work_struct work;
> 		unsigned long expires_at;
> 	};
> 
> There are other places I could use such a thing too, not just for fscache
> cookies.

No objection from me but if reducing the size of delayed_work is meaningful
enough I kinda wonder whether this can be generalized so that all
delayed_works are smaller. There's no fundmental reason to have these
smaller ones separate, right?

Thanks.

-- 
tejun
