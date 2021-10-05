Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CC2E3422D80
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Oct 2021 18:09:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236460AbhJEQLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Oct 2021 12:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236410AbhJEQLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Oct 2021 12:11:17 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C21C061753
        for <linux-kernel@vger.kernel.org>; Tue,  5 Oct 2021 09:09:26 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id x4so2637901pln.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Oct 2021 09:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DceQoeiEGKU+395NO5qpAXcwd6zYtA9Kz1VG3En8jJg=;
        b=StUyflCRX8LPeI0GR8M3xpBNvsuxh5KsirChuZRntlv9tLVLvCEPIlCt5UtDcHqgSi
         RfAkaEwbFsbaEw9ZXmG3MhNMppip3BA/NCHVuytu/6wY9gsoILHUI9aC9fYkzcvYuTyW
         WmKi96CjJOcmtN579Q5CqsmKdNAvlWgLrOeVJL0JdFznGKwXnfqN5GdSWUUUDAgIpoWi
         p4K2tgcwA27PZc7Wf/wlj3RUnsc++l7x4SdsN2yZ+zo/uDnbnPVjmucQeAk1M/zEq74f
         5pqPyvg/P122jz81fX8DPThEKMxO/8oU+LYb2lZ+ck8iX1bK3muO1DG8yn1o0W+AH7Xh
         sy0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=DceQoeiEGKU+395NO5qpAXcwd6zYtA9Kz1VG3En8jJg=;
        b=4JycQN6MTPAyL9x0qODmENamVkznBMtcnlYub+f1duP7Kx/2ilbqVbDzLwMUMC/jHr
         JQQVep7nckzNT1dr2ZJZcp9IOOolOWIH7S3aVrDxPhz46c43QzF4tu8XIpSTbpNiwMNr
         cQq0uVj4JnCU283gw51IdSISNnfwIpYGno6k3+Rzya8UycPcTAy7xHjOrc79FZfGYkbV
         h2uX8ADNTMi507M53AT5/gjq38+8yBZ05XKAOn6hbZnjeJbP4HHLhlOiOuvVDE1yHmoM
         91rGVqlgmNBwWpPCjTlXXXTtfl38a0WarQPEv2BBhGZ9vpJLfR7oAzNYem3JmxZEuj9j
         wm1g==
X-Gm-Message-State: AOAM533qVL+AsofsngVu+r/sBKHJ+QcYuoHgan9ESjFUYzsJfiMHTtZG
        diwLVCN3DinPYSYPK02gMvY=
X-Google-Smtp-Source: ABdhPJytVB5oSNvS3IjVCrW2NKdoZ2imJFRGRsfmVz0LyNb2VePLOZW2ViO1SIx9Y1G9klQAbJKifw==
X-Received: by 2002:a17:90a:2:: with SMTP id 2mr4771385pja.77.1633450165819;
        Tue, 05 Oct 2021 09:09:25 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id y3sm2918220pfo.188.2021.10.05.09.09.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 09:09:25 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 5 Oct 2021 06:09:23 -1000
From:   Tejun Heo <tj@kernel.org>
To:     imran.f.khan@oracle.com
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] workqueue: Introduce __show_worker_pool_state and
 __show_workqueue_state.
Message-ID: <YVx4s1GOIhisEc8N@slm.duckdns.org>
References: <20210928103106.391694-1-imran.f.khan@oracle.com>
 <YVsvAQ94ucYdGNVM@slm.duckdns.org>
 <447be1eb-87df-6941-1e5c-db79918dc77b@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <447be1eb-87df-6941-1e5c-db79918dc77b@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Oct 05, 2021 at 08:55:47PM +1100, imran.f.khan@oracle.com wrote:
> Please let me know if I am missing some information that may be helpful here
> and can be obtained only by dumping the states of other workqueues.
> 
> Then while going through the code, it seemed better to break
> show_workqueue_state into more granular entities which can be used later for
> cases such as one mentioned above.

Both sound reasonable to me. Do you mind updating the description?

Thanks.

-- 
tejun
