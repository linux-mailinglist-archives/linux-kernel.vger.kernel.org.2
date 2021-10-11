Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9CD42867B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Oct 2021 07:53:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232721AbhJKFzu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Oct 2021 01:55:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhJKFzt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Oct 2021 01:55:49 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 813D5C061570
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 22:53:49 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id om14so560471pjb.5
        for <linux-kernel@vger.kernel.org>; Sun, 10 Oct 2021 22:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=lIJ+XUhJ1TElhpQKwEpT4S7aJfZEXFOVkhMK+5OK5f0=;
        b=6miTw5RyDiGgFTqcgZc9O/crZqOnsIBUmL1Z3jTD0pryaBSQwoLKTNuZNK8vNMwTZV
         AcmpU2OhCwW9KiHPVdfN0ksHb0n5xruvtUsySXK4cCACzKaYH2fCSf+lIXpfdyDCcRzL
         fEZTNtkjdjJBaJ1kCWreLLx6SrBXtrmz56Mdwg4QbzTJ9eR9aU5Bd0RU9HMAw1hh4i2n
         UhTzCfYiqYL98qu7Z3IIp6dVR3px5z3B90zV0ZCevpDCvSWLRPttuyWSpixxeWzsmL5e
         caXg+VZwi03RfGI5Y5Zob9gDx+imPPNrOhj1yNEPy/EfwNzuVQ9WTylL9cALjeRQTZXn
         AHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=lIJ+XUhJ1TElhpQKwEpT4S7aJfZEXFOVkhMK+5OK5f0=;
        b=0m9j8z8KXtk3Fp9os+0FlMi2iiUBR3Vv2UIPIygMYFYLylGF+IgVydT46AGc7WVNv4
         LXMMxqykgCUlqIH9Q6W4LB1kREv8/2juMx0Ta9GydFEvmQxtF5xlXVOIWNO352XeASEI
         MmJbhou3H+wVN7pVGr32sREYL8W7HHz9+RfZUy11UTZJFEZdYucl2JODolfRLWGnoS1i
         Hoz4frge4bh+T8zyppG7WSr0hcUhFn2zAuzp0W0P5p1LagmsMQXJXBD6YFSPoL4jM1EN
         O7hVDzA0G1tldI08vScVe43zi6jHQ4wPipdqc1Gv4hL+uawPqm6XcMyuYNIbV+XlQlTa
         85+w==
X-Gm-Message-State: AOAM532HrM/y9wUAEJO62EJbzLbLHmH+92TK8IEbAg6rhnwFJUFgdAqm
        ijmdmdNsHhEDwqXm87CWvGyUow==
X-Google-Smtp-Source: ABdhPJyjZhIpdAYislrqj9WHCdSxqDDq0v/MEp12Ve3Sq2oDChg3vlUpJ7wmnE4v/TtrnmZjlv5NFQ==
X-Received: by 2002:a17:90a:4681:: with SMTP id z1mr28842601pjf.113.1633931628873;
        Sun, 10 Oct 2021 22:53:48 -0700 (PDT)
Received: from [10.254.148.242] ([139.177.225.246])
        by smtp.gmail.com with ESMTPSA id l14sm1180705pgt.17.2021.10.10.22.53.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Oct 2021 22:53:47 -0700 (PDT)
Subject: Re: [PATCH v3] mm: mmap_lock: remove "\n" in TP_printk and use
 DECLARE_EVENT_CLASS
To:     rostedt@goodmis.org
Cc:     mingo@redhat.com, akpm@linux-foundation.org, vbabka@suse.cz,
        axelrasmussen@google.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20211011021124.86248-1-ligang.bdlg@bytedance.com>
From:   Gang Li <ligang.bdlg@bytedance.com>
Message-ID: <ee3540d5-6790-7cdd-b8a6-3a478e4184f0@bytedance.com>
Date:   Mon, 11 Oct 2021 13:53:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211011021124.86248-1-ligang.bdlg@bytedance.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/21 10:59 AM, Steven Rostedt wrote:

 > Why did you send this? It should be two patches, not one. The rule is,
 > every commit does one thing. Now you made this patch do two.
 >
 > Andrew already pulled in the other two patches. I don't think this one
 > is appropriate, and should be discarded.
 >
 > -- Steve

My fault. Obviously you are talking about events, not patches. I 
misunderstood your previous email.


 > Thanks for doing this. Looking at the events, they can certainly be
 > merged into one.


This patch v3 should be discarded.
