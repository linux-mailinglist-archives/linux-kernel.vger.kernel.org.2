Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3595346DC3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Mar 2021 00:14:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbhCWXNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Mar 2021 19:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234244AbhCWXNY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Mar 2021 19:13:24 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CCF2C061763
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 16:13:24 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id b184so15923189pfa.11
        for <linux-kernel@vger.kernel.org>; Tue, 23 Mar 2021 16:13:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bsGu675No9dngICC5EINTZxy/TXuprPTCX9eZn7qRX8=;
        b=A9tWXssH6lXe+s+Mo/yW0uPEI15ANU7gWJVJZZVJd0rfcK8lWLO0WAXh4MFgkUiYtN
         89W8GOvX9rK0us8Fo4WEv8gPaIHIb5PfgkeBzIFR2q1XEda5KCXJ2KgdVh3nivg0SvNy
         Gm6pdJYys81RdDzgUBkYa9BTxInvkLDpYJswbLx0Hhjt6L9EO297Tna03HtKpZFqAHWJ
         URH4LRN/BlzLRn3RpP2HnHwZNT8KuTRmhK/Tg6WSGXW2niRNnkXoFaqQBX8K2tkULOhG
         W3K8j+ES/aNkGAgiil+jKX86/f2g+vqMSNIaGyEEtIuqs6Qz12wadRB1jyzZwmPRCLjG
         ZW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bsGu675No9dngICC5EINTZxy/TXuprPTCX9eZn7qRX8=;
        b=d9CVgcX7GHHZ3QvcPcHQlQzv2Odlelzx//M0drbpEmUNLMsr0c/dVV+p2U9khBR9MR
         ZgUlqT1Zp7q0F0JlFxwUV7J9BrtzMFZUo8M9XvzUhufFczlVP3U5HuPCsvSZ6lZd3DBy
         tqPnZh7OObX52c1Ve6yNlQST1jfNIdAeBLLxggFghKf0P07TFgAeDw8b+69yNz2O0GeW
         rE9rCJ1xbu/PRG4HPZ/mRwEj8/Ali0vmS4uLb0hNIX8snfXkmUh5Ninb7QE944hDOWxq
         kbk+FxAU+NLnA+2ZNKliJ6AkKFvvrdfES2o84ZcIgsNvgwfmFkMXbo2vz7GAiMKMOB2P
         MlCQ==
X-Gm-Message-State: AOAM532wGeaysb/skBom/o8eAoEYHgxTK8/dg7RkvGGA0iJBz5daum1g
        I7gPOinviv2dhL7Y5QKq+Zbljw==
X-Google-Smtp-Source: ABdhPJwGJ3NjOc0//IwwbuFpZjJZMHw3huP0iHLxuzJL8uxTuwPMA+13T036eR4lXK2IQ3KtpAKQrg==
X-Received: by 2002:a63:6982:: with SMTP id e124mr538624pgc.46.1616541203850;
        Tue, 23 Mar 2021 16:13:23 -0700 (PDT)
Received: from ziepe.ca ([206.223.160.26])
        by smtp.gmail.com with ESMTPSA id f21sm249668pfe.6.2021.03.23.16.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Mar 2021 16:13:23 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1lOqDB-001jsH-FT; Tue, 23 Mar 2021 20:13:21 -0300
Date:   Tue, 23 Mar 2021 20:13:21 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Cc:     Praveen Kumar Kannoju <praveen.kannoju@oracle.com>,
        leon@kernel.org, dledford@redhat.com, linux-rdma@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Rajesh Sivaramasubramaniom 
        <rajesh.sivaramasubramaniom@oracle.com>,
        Rama Nichanamatlu <rama.nichanamatlu@oracle.com>,
        Jeffery Yoder <jeffery.yoder@oracle.com>
Subject: Re: [PATCH v2] IB/mlx5: Reduce max order of memory allocated for xlt
 update
Message-ID: <20210323231321.GF2710221@ziepe.ca>
References: <1615900141-14012-1-git-send-email-praveen.kannoju@oracle.com>
 <20210323160756.GE2710221@ziepe.ca>
 <80966C8E-341B-4F5D-9DCA-C7D82AB084D5@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80966C8E-341B-4F5D-9DCA-C7D82AB084D5@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 23, 2021 at 12:41:51PM -0700, Aruna Ramakrishna wrote:
>    There is a far greater possibility of an order-8 allocation failing,
>    esp. with the addition of __GFP_NORETRY , and the code would have to
>    fall back to a lower order allocation more often than not (esp. on a
>    long running system). Unless the performance gains from using order-8
>    pages is significant (and it does not seem that way to me), we can just
>    skip this step and directly go to the lower order allocation.

Do not send HTML mails.

Do you have benchmarks that show the performance of the high order
pages is not relavent? I'm a bit surprised to hear that

This code really needs some attention to use a proper
scatter/gather. I understand the chip can do it, just some of the
software layers need to be stripped away so it can form the right SGL
in the HW.

Jason
