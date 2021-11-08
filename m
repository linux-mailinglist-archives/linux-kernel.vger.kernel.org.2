Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEC3D4498C9
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Nov 2021 16:57:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239297AbhKHP7R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Nov 2021 10:59:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239202AbhKHP7Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Nov 2021 10:59:16 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 887D2C061570
        for <linux-kernel@vger.kernel.org>; Mon,  8 Nov 2021 07:56:32 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id j9so15546344pgh.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Nov 2021 07:56:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/g/s0/C4qftb89FVN3aA4E91PSRYYBT+PXfpn2fQN+w=;
        b=eCWiTVoBM/szy6RP+MkvMlqeJM9gJeCgBFtgJvPxLIE8f7UMl8VeUBksizzQJNs6Sz
         5shemjk1W30+oQN6iPdmKvpxvPIs8zX1GHfJBmRt7A70FuqhPjmZEqz/JPVfyy6M8Hg6
         ulpJfC7A3eFgnJ0bUxVWvtyZ7j9xp2wYSLUV3vmTPl88jrjn0w+iXEkbhApTbup/TCvL
         MuFohdlaJ1avH1yxfdHwaxzLnpe+PMMMeouITmL7ZXH4g6LO2mHABP1RGiAM611b33vb
         TQpqUIndobdeIdcOP1HikEX5Q21Q7VhQqif4fZ8HKGXkoCO9IjKZAtp785zkMMNJzKvy
         xIqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/g/s0/C4qftb89FVN3aA4E91PSRYYBT+PXfpn2fQN+w=;
        b=QrHvgOUZTzab3s5QYK+JkjuJ/DZlRGHPqSy/ZDpjXh1nWwR3nDK0DrSToP2/pFQoAb
         vHXeCflPiecsFLG2CE4uNwA5pr+JeXiCBmNGNvv4WyU+Y0mCub2JInA3vMwlAV1LsTBF
         tjaLnSJ9E7tJURvLJg6IVApONGZwoTQGEYbphpQGHo7iV5pfqa0t240FhomtsFKvA7DL
         GlQ6u35zaVBZ53veoz1eGzbAy55Bqn3UiWFI8A5by9Sxv+OILjZP3kvZkD2RDOZDg5jC
         U9O0YZd55LRsAeaF8FMwvRr1HiVfATJCurOoZC2XvOgE8FTb4XEW2AidIvBcHyzRr3jV
         guJw==
X-Gm-Message-State: AOAM531f5x5OWHtlGgZ0Cfte5u15L9epYes3MOuPKDsM+P2Ctm86DjTX
        t27Tf+r5X2lTp4/b8UuUO6I=
X-Google-Smtp-Source: ABdhPJy5GKUzXM6T0G2GdpyIIYtgEZ43r1gjyxVz0tT83uWGll+mgL0nrFYsXwqw3r6EPQfQPdQtDg==
X-Received: by 2002:aa7:8d44:0:b0:47b:ee6c:5ca4 with SMTP id s4-20020aa78d44000000b0047bee6c5ca4mr428951pfe.49.1636386992134;
        Mon, 08 Nov 2021 07:56:32 -0800 (PST)
Received: from ?IPV6:2601:645:8400:1:99e5:9255:239c:47f4? ([2601:645:8400:1:99e5:9255:239c:47f4])
        by smtp.gmail.com with ESMTPSA id g7sm3333985pfm.127.2021.11.08.07.56.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Nov 2021 07:56:31 -0800 (PST)
Message-ID: <5724239b-2819-ba97-2350-675abedc241c@gmail.com>
Date:   Mon, 8 Nov 2021 07:56:30 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: Performance regression: thread wakeup time (latency) increased up
 to 3x
Content-Language: en-US
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yunfeng Ye <yeyunfeng@huawei.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
References: <035c23b4-118e-6a35-36d9-1b11e3d679f8@gmail.com>
 <YWlBUVDy9gOMiXls@hirez.programming.kicks-ass.net>
 <5fe0ffa5-f2db-ca79-5a10-305310066ff9@gmail.com>
 <20211015100401.45833169@gandalf.local.home>
 <8691a8ec-410d-afe8-f468-eefe698c6751@gmail.com>
 <YW1ZjroFfmKM9HJe@hirez.programming.kicks-ass.net>
 <fff246da-2a10-3463-614c-e54cd8cf78e7@gmail.com>
 <ae2debfb-c780-7164-09ee-ea295004d173@gmail.com>
 <20211107155616.GA269390@lothringen>
From:   Norbert <nbrtt01@gmail.com>
In-Reply-To: <20211107155616.GA269390@lothringen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/7/21 07:56, Frederic Weisbecker wrote:
> 
> Is it possible for you to share this benchmark so that I can try to reproduce?
> 
> Thanks!
> 

Emails were sent. It's currently 1000+ lines of largely experimental 
code, so a bit too much to post here on the list... (and in the middle 
of adding more).
--Norbert
