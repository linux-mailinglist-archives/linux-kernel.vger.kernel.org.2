Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E75AB3CED70
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jul 2021 22:29:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384539AbhGSSbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jul 2021 14:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383702AbhGSSJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jul 2021 14:09:17 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D330EC0613AD
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 11:35:28 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id j184so17714737qkd.6
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jul 2021 11:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=lJcS5lEZjjAoYShvaryNw6SqSqh0qq9Bkj+sXFi2sZg=;
        b=jyr/9Lo4f72nip7mLbZDDyHNaF0TEL+Wmtrl8CEg4b4in9E3PMKzWylZ8WxiZNUkzs
         F0CSRmrD7wHD9mHI7TJUrrfT4n/oGr+uEAgWdaJDZb2DGbJGKtN1tOAHKCl7+WLtVKqg
         VX1yYvH6UttwWnYTUOp35QdkFkooIwez4xxV6rHyzheNA/mKs0JD2aT3p2C7Q7Ah2BBx
         tAlla36PSJuagFPvxo3PvKiJ7Ag5Jg0YlhWNNlb/55+4pRrYPk3wVsI+kBGYz+zyY87j
         7Doc+b9ldWgJefHMiiLnMRIdhukpYp5NZh5ZLVOs+VoDKZgeVunbmGLuFiHk5h8TinE4
         m8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=lJcS5lEZjjAoYShvaryNw6SqSqh0qq9Bkj+sXFi2sZg=;
        b=Lg9YHbCaxDXm76XzswXf3ZN3ZaiBQ5zX2hxkR57MrcWYxcxjVxadVDWNEWXj2BqBxq
         T04r8/VeRaxcGnRSom5HS3iLevYDofd99Ys2QHo4hb4xklKVIjiZudIQUW9uwTxt/3ke
         KUebezHdEcXlN/R6ZI/jn+05PxdkkHrOL4tELz/+SHaOVdRX7XSkbhnFRm/PxpUcOkXt
         GNi4ULaVH+CQeMFLHF8q9Ie9+/V7YG+1sGTYcQd2BRaxjlQaK6VuObFuUOJWgEy5nrR9
         iYViLbib7VdSo34PqAPyKRf0yCcoievP1+J6NuBV4RdYV4xeNNQoSFoEIA6786EM5hyG
         u2JQ==
X-Gm-Message-State: AOAM531kbCFjgBPyKTE8A7GbLE0LQPJdpunkk/wj+5FD/g8KFi9K22rr
        WFEnFpskGTwXfJhf/Xz6kYk=
X-Google-Smtp-Source: ABdhPJw4mz753gKXgKu4ViSjC0ATjRPZlo3T2nBCvnJT5DIl2pFp5dFalaWfb4U3+kdaTs7vdCK+0A==
X-Received: by 2002:a37:670e:: with SMTP id b14mr25754880qkc.240.1626720454540;
        Mon, 19 Jul 2021 11:47:34 -0700 (PDT)
Received: from ?IPv6:2804:14c:482:92eb:ffdf:6b35:b94d:258? ([2804:14c:482:92eb:ffdf:6b35:b94d:258])
        by smtp.gmail.com with ESMTPSA id r139sm3766145qka.40.2021.07.19.11.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jul 2021 11:47:34 -0700 (PDT)
Message-ID: <4cbfa11cf8f52d47d6ff0aabe01e4e51918d3c58.camel@gmail.com>
Subject: Re: [PATCH v5 04/11] powerpc/pseries/iommu: Add
 ddw_list_new_entry() helper
From:   Leonardo =?ISO-8859-1?Q?Br=E1s?= <leobras.c@gmail.com>
To:     Frederic Barrat <fbarrat@linux.ibm.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>,
        David Gibson <david@gibson.dropbear.id.au>,
        kernel test robot <lkp@intel.com>,
        Nicolin Chen <nicoleotsuka@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date:   Mon, 19 Jul 2021 15:47:53 -0300
In-Reply-To: <ae8fe44e-24c1-9d5f-70f9-96098167170a@linux.ibm.com>
References: <20210716082755.428187-1-leobras.c@gmail.com>
         <20210716082755.428187-5-leobras.c@gmail.com>
         <ae8fe44e-24c1-9d5f-70f9-96098167170a@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2021-07-19 at 16:14 +0200, Frederic Barrat wrote:
> 
> 
> On 16/07/2021 10:27, Leonardo Bras wrote:
> > There are two functions creating direct_window_list entries in a
> > similar way, so create a ddw_list_new_entry() to avoid duplicity
> > and
> > simplify those functions.
> > 
> > Signed-off-by: Leonardo Bras <leobras.c@gmail.com>
> > Reviewed-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> > ---
> 
> LGTM
> Reviewed-by: Frederic Barrat <fbarrat@linux.ibm.com>
> 


Thanks!

