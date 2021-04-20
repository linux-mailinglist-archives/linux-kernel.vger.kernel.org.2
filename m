Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D89F7365EBE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Apr 2021 19:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233286AbhDTRoB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Apr 2021 13:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbhDTRoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Apr 2021 13:44:00 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 756FDC06174A
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 10:43:28 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id j12so21070601edy.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Apr 2021 10:43:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=0r7+oPVQUGjxLf8FALe8TJW9eBm5+3uLrgjVhTfye+4=;
        b=BSG5H33CgJoTATLJlnioz9ao30qBfE7WRCscMQdJBhyGJMHRruINfUieQJIIXsD6Kt
         vFO96MKEBJrKKDSnjPwCn2LyIrczEC3lxRXb1dJoSrObxjuGrysHSWbOzCNw/uj61dQr
         FKAAyWQYVuuQiA+PYNgFoY2XmXy8vxiSXufXQb1JCNMmI8I75XQdeuZSzZob+Dw6elqT
         7gWqS62LucKyEwGTWhY23SYyrwm3sfFfz+yzxHm72SxZDrp/U6Nb+RuwvOlmeqosRtox
         0SbfU0cpDhcoBbKSH1+8lWUmElWozKwVVCdDw5oPG8BTB2icPGeMNW+fF3MoSJ5k+OIT
         DZbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=0r7+oPVQUGjxLf8FALe8TJW9eBm5+3uLrgjVhTfye+4=;
        b=eccuSG5xbPrEt9Gm5cY/enc+CnQBpjMptUSZQSQGfjyBw65kFOGbtbDyjBRulO0xEk
         o3vCMMb5m+wwKB9zeaFOXsocN1FsSQnHsmiYQy2kO+qFELwyQMqp/MdtgMehA7i+kOVB
         t9FltQNOTU1hLjJBVFP+2Y2RLAAdJvADUbX9c5kqAKlKV5Wvo7Z+Ph7eSDWptnBF9lLb
         ivcCIW9fGtDdAI1VM/QFtKtUPdE3EZeVa+Hdi7ROQOXTAG79TvlGKK0t8t3KswnUrfh9
         YzUyBvXywNd6FvHjHTMFiF/ZVqejln8dV4dNHNu+lMIPW4NJBbhxCX7hq7GWfSNUGNgu
         6bog==
X-Gm-Message-State: AOAM533TDVDYFbQyOBOroaLt7YbaEKvDkb11RxkhV8NV5TmYrCda86lJ
        YJptI1T/6iZEYFbkX2CVSSk=
X-Google-Smtp-Source: ABdhPJwYKW2Za0LBbQ/9FSC6HH15TKXSedEhRXOqcIC+7cERpjoJhxBd+TLdg2To7pSt6opp2MrFqA==
X-Received: by 2002:a05:6402:646:: with SMTP id u6mr33526522edx.74.1618940607098;
        Tue, 20 Apr 2021 10:43:27 -0700 (PDT)
Received: from eldamar (80-218-24-251.dclient.hispeed.ch. [80.218.24.251])
        by smtp.gmail.com with ESMTPSA id l9sm12919257ejz.96.2021.04.20.10.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Apr 2021 10:43:25 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Date:   Tue, 20 Apr 2021 19:43:24 +0200
From:   Salvatore Bonaccorso <carnil@debian.org>
To:     Chao Yu <yuchao0@huawei.com>
Cc:     butt3rflyh4ck <butterflyhuangxx@gmail.com>, jaegeuk@kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to avoid out-of-bounds memory access
Message-ID: <YH8SvK+OLSKAEYpJ@eldamar.lan>
References: <20210322114730.71103-1-yuchao0@huawei.com>
 <CAFcO6XMak8GSRqQbZ3nPdGvV_eM6DL0+P0z1X2y0G9hkrccaCg@mail.gmail.com>
 <beff8953-d91a-c677-f50a-3aba27c15dde@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <beff8953-d91a-c677-f50a-3aba27c15dde@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Tue, Mar 23, 2021 at 02:43:29PM +0800, Chao Yu wrote:
> Hi butt3rflyh4ck,
> 
> On 2021/3/23 13:48, butt3rflyh4ck wrote:
> > Hi, I have tested the patch on 5.12.0-rc4+, it seems to fix the problem.
> 
> Thanks for helping to test this patch.

Was this patch applied? I do not see it in mainline (unless
miss-checked).

Regards,
Salvatore
