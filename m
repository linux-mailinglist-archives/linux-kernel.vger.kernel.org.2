Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5EF39BB37
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Jun 2021 16:54:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230158AbhFDOzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Jun 2021 10:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbhFDOzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Jun 2021 10:55:46 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55574C061766
        for <linux-kernel@vger.kernel.org>; Fri,  4 Jun 2021 07:54:00 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id h20so9539786qko.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Jun 2021 07:54:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ImIu3fL6shV47GhGV6CKj+i96a8yaRe5SvKjMp99G0Y=;
        b=gVIAQxY//w9bw45Hjb6SpqgJyBF6XFRX894mZEhbFVU4yvVlckh1unG54rPzxZ608k
         wy9w5XCfQZqrU9OBAOqXAfb2LqaaVuCOBSzV5yj7QBiUZ8PSFeIkdkeNB3AbmAcgKD4c
         SGfFXs0QTSFm0VZ+yccJVYaPTA0MHBCXQ8vKaOAPT3BmApYoqJpYWLyfSkwdxaBhNRZ0
         6pVV+r/1nvLlsg18zga76/GvrK6YFnlaB38EMGdZclqlTDkq3skvykD3+h7ew7Lz5Mo8
         T28SX+5QGOjS40UQzYhlSEaWrVbPVbpZvUENlYlG9vquC5lX9/51HBOkPv3Se/n4gmrt
         cbbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ImIu3fL6shV47GhGV6CKj+i96a8yaRe5SvKjMp99G0Y=;
        b=WbSKsJaojIpmORR2F4nVRM/WEmCumva53blFhpfd0W4wuDLeHdcvlesOVV5bVnpcEu
         fkihZXvkADsqWPIsTKNfFH/ReD1/H0Yyvrvp+EL2JurbclL/FC5hE362EvvSz4T7eavR
         Mu2dPf93QhZf4gHyCMjyd82mB1UtAnOD/1iUy3cNGf8lXHWQUVFFWQ3QKwXUk7Q8BjwD
         UfxqhBdV4OoacPuTk3KeD53uU9gV7qwahJwWOm7yakWoqD15hx6gCMVOLwjtJWcSn5in
         xOOD2jtuMVZs3BagR0sva07gyPVFBuAZ8jgt6RhWR1rxw1jvgplfhFuQQnyFFKUPr5OL
         lBRg==
X-Gm-Message-State: AOAM533eLhoolTit8sH9Ad6Jh4qX9jczkALW4vytgZEmpDB+Toq5LzPr
        8WC0W6UfvWXfzixbxoQrFfs=
X-Google-Smtp-Source: ABdhPJyZvEwfSQF0KoEMhpapimJzG5oM5ks8K+mY2za55/qkwNdJLyMww+fypsXqPBm7xPAZNqcn6w==
X-Received: by 2002:a37:4697:: with SMTP id t145mr4762715qka.188.1622818439442;
        Fri, 04 Jun 2021 07:53:59 -0700 (PDT)
Received: from localhost ([199.192.137.73])
        by smtp.gmail.com with ESMTPSA id p17sm4042557qkg.67.2021.06.04.07.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Jun 2021 07:53:58 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 4 Jun 2021 10:53:58 -0400
From:   Tejun Heo <tj@kernel.org>
To:     Julian Wiedmann <jwi@linux.ibm.com>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH wq/for-next 2/2] workqueue: clean up for_each_pwq()'s
 documentation
Message-ID: <YLo+hp+kl94eC6FT@slm.duckdns.org>
References: <20210602111655.3808580-1-jwi@linux.ibm.com>
 <20210602111655.3808580-2-jwi@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210602111655.3808580-2-jwi@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 02, 2021 at 01:16:55PM +0200, Julian Wiedmann wrote:
> The if/else clause was removed with commit 5a6446626d7e
> ("workqueue: Convert for_each_wq to use built-in list check").
> 
> Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>

Applied to wq/for-5.14.

Thakns.

-- 
tejun
