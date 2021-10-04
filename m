Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E749B421452
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Oct 2021 18:42:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237338AbhJDQod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Oct 2021 12:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237220AbhJDQoc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Oct 2021 12:44:32 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63BDFC061745
        for <linux-kernel@vger.kernel.org>; Mon,  4 Oct 2021 09:42:43 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id kk10so2692916pjb.1
        for <linux-kernel@vger.kernel.org>; Mon, 04 Oct 2021 09:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tgPU6J2Drb2mDm1j+BxG1s1+v9UPCa5fGZfUfMeBk0E=;
        b=YwlmHsaxC6bcFPsLEAIgw6MvhWN2vsJZHdO6uUyIzi0D+96g6NbRLM5sTCSu00t9aL
         5+MKH/k7/NYS3ew4kYiP5263BKUNnrJj+dhSm1qVfaofDzIbK8/eZc5lywW/+ZV5wLG2
         S1Cu9FR9fS8m5BcZ5oPfxUT7kEkGjsfGuYIvk/mCaXR+XH57ijnIPG1WIEKS8kde1dMw
         3OC+irY0Idlz3TnW8cwf1+H63Na67xzRsg/QCqKlXjFw5rrC3U4D/+xuv4+eTpofD6Bc
         RJsNyLIhixOTJnP4cGZnCQ3oQc/9j65XNDUdoJaDyrRPQep41uft7RfdUIKfqO6TcIoC
         qAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=tgPU6J2Drb2mDm1j+BxG1s1+v9UPCa5fGZfUfMeBk0E=;
        b=QlmRL6ru0npi8WV9/lprg1W49WLinmQmnIFXANzqAAdzDiEoNg8D2fahkNBETtl4cV
         EtrXyQ1LxH4SgmfXdVCd96pa6yfTK5uPdQarEcWjf0Zo09VqzAMqTjejpxWyTIdTBheB
         gkKXBFpQMGS20EIUNI/POdgoG7OKdXDtEYH0Hk0H7GtdUUrvV4dNcWT7BvitjBtLrpca
         pgnVdOeRYARPrm0Cebj74v1HrlcrmxiF+CwmlOMgsB1UrKjOZv1Pw+mPymOCaORsoPXM
         IOvuPYVajjunHQzDNCTco22OSl3Y2ajD22CKskg6i8E+NKHx+ygr4MNBsPsUD4/pl1AM
         beug==
X-Gm-Message-State: AOAM530q6qNv1LSv+4KIcYmAjgrySUfRzSsXIK/XYH43Dclv2ib+1wTW
        oQo2WH1kx88eaMXMLLxzE2W5uQHTMlg=
X-Google-Smtp-Source: ABdhPJy/SDPnn9MPRLKOOuKrVHwgJbDbdkg86zUcT8sPJcw0HreBbveVDRB9+Usbk3b7V/R9l6N8Iw==
X-Received: by 2002:a17:903:2283:b0:13e:6848:b978 with SMTP id b3-20020a170903228300b0013e6848b978mr627962plh.44.1633365762836;
        Mon, 04 Oct 2021 09:42:42 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id j9sm14713284pfi.121.2021.10.04.09.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 09:42:42 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 4 Oct 2021 06:42:41 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Imran Khan <imran.f.khan@oracle.com>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] workqueue: Introduce __show_worker_pool_state and
 __show_workqueue_state.
Message-ID: <YVsvAQ94ucYdGNVM@slm.duckdns.org>
References: <20210928103106.391694-1-imran.f.khan@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210928103106.391694-1-imran.f.khan@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 28, 2021 at 08:31:06PM +1000, Imran Khan wrote:
> Currently show_workqueue_state shows the state of all workqueues and of
> all worker pools.
> Divide it into more granular functions (__show_workqueue_state and
> __show_worker_pool_state), that would show states of individual workqueues
> and worker pools.

But why is this change good? Are you building something on top later?

Thanks.

-- 
tejun
