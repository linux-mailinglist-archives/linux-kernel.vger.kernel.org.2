Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 03F8E3EBE14
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Aug 2021 23:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235000AbhHMVzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Aug 2021 17:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234831AbhHMVzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Aug 2021 17:55:47 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9B2C061756
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 14:55:17 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id cn28so5581657edb.6
        for <linux-kernel@vger.kernel.org>; Fri, 13 Aug 2021 14:55:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=P+Z/RYz/jriuijQpIN7Fhw40kHDI4JM4DRM0zPmZRTY=;
        b=VeuSfTAea9nDlLQ8zYxcK0qWXy7SzRkRFt2hjrCQ7JiEf75tgQcKWHrOxgS55Bonle
         8sk6K+9xXJQWVdPdbjQxXz/IU0eJ1/BpZk9xHSB8IVXeDM6dT+HUMQ/R9kMHo+mCmJbg
         T7LtrpDnbZnCYtyOwdOpJ1tzKxdU+8Sl+fDp+RZ3t5ifybxVLDw31ntMRlFZhzKUWFyN
         QpXnFHtOT8XRIHF9tbdkC/1Zn5+aiZFduh0q9ALxbhv6maAdysYKJhvjMBZROUx4xGUB
         N3RN77TH+NophsNw66AobC+cM49E1NfcjWZSo7CdwMajsUYfhd377RY/x4hHyM46Cn9Y
         nU6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=P+Z/RYz/jriuijQpIN7Fhw40kHDI4JM4DRM0zPmZRTY=;
        b=Iins6Ym4zkcunINDOBvtja86Fyajazm4LrD+a5JZXwerjSKF2BIeVT/LKIPRH8o/kr
         UvcmacBidSsWiAreehQ4m5RaW9Ci8h4AAUDLNpA1KyWJdZXfqOqQxO1n2RjwUEHCH/5O
         cTYnvX2CtNOY0INsMjIcjsDuKSZHcsTZ5TjxkuswBLLjikBA9PIX1IOIYglzAbopbe0R
         +K+MMYK02T/YQPDqfV99jIjQCddlamlTHyfIF0uSMEBzOOhM53Xg8uFOWBVvZRNXZ9DT
         pVvekAViKofDjPwT71y3WmYMwjZIvsVsCSiZhWRgqg1iDRXF7VQNYXjFejOOFbTxJrcu
         JmSg==
X-Gm-Message-State: AOAM532IRxTLpupkdQlX1g8Wt9KAkMY1Ig9IQUW8QPWn2zqCZ0thGeTu
        GxhiwkXkJOonRK6nnhjxaME=
X-Google-Smtp-Source: ABdhPJzHbUlQQIzzv3T9J80QbmMZRWzFGGEswNHk4x46iK0pDa74tVImS72KHHsj8knXm/3+OXVXmg==
X-Received: by 2002:a50:aa87:: with SMTP id q7mr2807690edc.157.1628891716371;
        Fri, 13 Aug 2021 14:55:16 -0700 (PDT)
Received: from localhost.localdomain (host-79-22-109-211.retail.telecomitalia.it. [79.22.109.211])
        by smtp.gmail.com with ESMTPSA id dg24sm1442864edb.6.2021.08.13.14.55.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Aug 2021 14:55:15 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Phillip Potter <phil@philpotter.co.uk>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Nathan Chancellor <nathan@kernel.org>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Remove unnecessary ret variable in rtw_drv_init()
Date:   Fri, 13 Aug 2021 23:55:14 +0200
Message-ID: <5820125.tyerhIWj94@localhost.localdomain>
In-Reply-To: <20210813201418.4018631-1-nathan@kernel.org>
References: <20210813201418.4018631-1-nathan@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday, August 13, 2021 10:14:18 PM CEST Nathan Chancellor wrote:
> ret is unnecessary as both error paths set the same error code so just
> return that directly.
> 
> Suggested-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> Signed-off-by: Nathan Chancellor <nathan@kernel.org>

Much nicer!

Reviewed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Thanks,

Fabio


