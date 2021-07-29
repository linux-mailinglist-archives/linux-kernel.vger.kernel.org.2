Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 721063D9FBA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jul 2021 10:39:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235230AbhG2Ijf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jul 2021 04:39:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234878AbhG2Ijd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jul 2021 04:39:33 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA71C061757
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 01:39:30 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id n11so3179681wmd.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jul 2021 01:39:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=agpE2qpnM3MPOVUPOazHdzoBkFmrEncPcd+su9CzIwM=;
        b=UG+T5IdDJfCgXm3HNK5QBioYYVP04hv0EjL9AKuANNqnQieI3ZXL+iwUbhsbPlnWu3
         WxSjz32so/m1/HjCJi82gpzs5FmpmfDNY/0c6j+Eut/r7/YkOrkod2uXsRAb8oB+UoXv
         mzJdNEVwZE65gYPF8u5fHdreizAUN6pnSGVvlaz9Y3FfcL9oVtdocSsa1ewFGAEizDgR
         AoIlhU5p+9H9+fg7jpmTfQuTwf9OwrLSYa/2hhjI2xjnyaZO6d4O7u6SoUCZsg+8xYSf
         bnc/Xo6iSjXc9Hk4x3ucgmmM8Cpf0RThHD5cF4yUJ7PY8nSg0R3xBYMgJHyFgRk2T83J
         O7Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=agpE2qpnM3MPOVUPOazHdzoBkFmrEncPcd+su9CzIwM=;
        b=Rl+8vggn6KYWzxmRn9OM0QJ9sQCZl9xjOP//Ja282oGB03hB47X+YO/h2dupfRl/u0
         Xpb8evLEy2wp+YTzMH2ZtgmTqzSSTuC3elYYCAW71Xl5UvJ3RHnLzYh8KhlJh0PeU3E6
         z9zwfZ+DxpwTLA63Va/7kAOsq67T29LMGf7hsxYQEk/erJZQS3HKoay2MdrZkFf+WHFN
         NtlpUP/LOD2ZAEM0ZMca9UJNmYhXiUdb8Y6gzY+FEQlHrIVrsMOou4A4UWfS8IU1tSX7
         //8EU/39bgYNzTBhrWug3+ZYNSOGzgoZPIkkwZ6VxRzyX3GFykGe4DCAxH5E3fiZXE9T
         bCJg==
X-Gm-Message-State: AOAM530PcVZA2ICEYvHtRRjVijdRoyp/1AnFgD+QOKRTRiRYK+FatQB5
        V2u3pQxvOtsghMyMJCYoFhk=
X-Google-Smtp-Source: ABdhPJyqC/gEycKk7HpCqO/s1tPdqe9bqjvUmekyYPez5oo8vuBOshimqZ69n4PJynQuWbOOSPXs2w==
X-Received: by 2002:a05:600c:4f90:: with SMTP id n16mr3573896wmq.71.1627547968581;
        Thu, 29 Jul 2021 01:39:28 -0700 (PDT)
Received: from debian (host-2-99-153-109.as13285.net. [2.99.153.109])
        by smtp.gmail.com with ESMTPSA id t17sm2491407wru.94.2021.07.29.01.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jul 2021 01:39:28 -0700 (PDT)
Date:   Thu, 29 Jul 2021 09:39:26 +0100
From:   Sudip Mukherjee <sudipm.mukherjee@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 2/2] parport: serial: Retrieve IRQ vector with help of
 special getter
Message-ID: <YQJpPmq2Du037U8b@debian>
References: <20210721150216.64823-1-andriy.shevchenko@linux.intel.com>
 <20210721150216.64823-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210721150216.64823-2-andriy.shevchenko@linux.intel.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Andy.

On Wed, Jul 21, 2021 at 06:02:16PM +0300, Andy Shevchenko wrote:
> pci_irq_vector() may be used to retrieve IRQ vector for a PCI device.
> Use it instead of direct access.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

For both the patches,
Acked-by: Sudip Mukherjee <sudipm.mukherjee@gmail.com>

Greg, can you please take them.


--
Regards
Sudip
