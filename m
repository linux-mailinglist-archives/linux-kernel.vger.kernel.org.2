Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06ABC3CBA65
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 18:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229591AbhGPQRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 12:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbhGPQRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 12:17:32 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85CDEC06175F
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 09:14:34 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id my10so6646976pjb.1
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jul 2021 09:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=dFXFnq110ndn5LMgzlnTYUCZIjchSM1BceT4cu1e1RE=;
        b=Vxq6R1OufDzdptMWI8/b03pmRt+2pshKnqsWMWFTGmbk0D6XgrbBQwD2ew3KI+40s0
         5YWybc5enNNh5niPRa9ApvQQwV5e82N9GdPg6gejCYQ6h+L2vEJHtpWUIfQ3WNqGeP10
         hJMJRMxia/yZHAz2g3m4LdXltj6eD3V9DdwM340FeC+Pk23NVpumA8iopFhwpJSCb5eE
         yz9WoM3Scv7LhVqKLfIP9OND/H5LnDca4+x+N+ld8Uw7I21dthI1PQQMRqWd3oZFlIgi
         zZVPt5IyC8cbSVe+F7bkYhgkJwJcqbnmBm1oK/RbwipolunEFGDENGpGMKQXyxsU/NZD
         Qq/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=dFXFnq110ndn5LMgzlnTYUCZIjchSM1BceT4cu1e1RE=;
        b=p3HOVrVTi0MswqTCO+Jy2nrkOApdQp73iDCgvkqhkjisXIG3kOLwn0e7QNvCr8La/4
         SNQ9Pr/jhgPNso6HgcsAOR8Gz9YdBmUm9CjeIozxVg+jlHxKJUJFS0SoT6DhFNI8lpDV
         hGHMdvGcbLaliJRWk/dSZwvATJIFe5QdTRT1RUb8og00DAvFO5e1ipqVpbJlYmBaktD6
         hfbxFAiRYyHkp4a3Bs7hjTo0O/l3CArK8fN4eXpMmMajJcu3IKLBRD09T4W+To4uZ/Z4
         wm/zA2fC4600HiAiTzttKLE7XLLXF1N/fdiqVAyrt8zbZzWX7KTCsJVYXKnGz6zir8n3
         wd8w==
X-Gm-Message-State: AOAM531sg1vY5XKCwWo17bli3ezgFd+3HtnXWkIjISZibRm8BoQUUzjm
        jYq9dUEvwyajInz5+417mzw=
X-Google-Smtp-Source: ABdhPJxhUg8ql6durkMRqhHYxUe4ID6fnTwjr1F6Qb8dBjP+CSbkGdgTs1ds+NUGc5tcaJc4XKTZJw==
X-Received: by 2002:a17:902:d50a:b029:12b:59a9:9586 with SMTP id b10-20020a170902d50ab029012b59a99586mr6271174plg.62.1626452073786;
        Fri, 16 Jul 2021 09:14:33 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::5:37b9])
        by smtp.gmail.com with ESMTPSA id 1sm10982564pfv.138.2021.07.16.09.14.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jul 2021 09:14:33 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 16 Jul 2021 06:14:29 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, jiangshanlai@gmail.com,
        xuqiang36@huawei.com, paskripkin@gmail.com
Subject: Re: [PATCH v3] workqueue: fix UAF in pwq_unbound_release_workfn()
Message-ID: <YPGwZVsE0AmkpziS@mtj.duckdns.org>
References: <20210714091934.3124170-1-yangyingliang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210714091934.3124170-1-yangyingliang@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 14, 2021 at 05:19:33PM +0800, Yang Yingliang wrote:
> If apply_wqattrs_prepare() fails, the new pwq are not linked, it doesn't
> hold any reference to the 'wq', 'wq' is invalid to access in the worker,
> so add check pwq if linked to fix this.
> 
> Fixes: 2d5f0764b526 ("workqueue: split apply_workqueue_attrs() into 3 stages")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Suggested-by: Lai Jiangshan <jiangshanlai@gmail.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>

Applied to wq/for-5.14-fixes.

Thanks.

-- 
tejun
