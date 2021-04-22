Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 401B33677DB
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Apr 2021 05:21:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbhDVDVb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Apr 2021 23:21:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234247AbhDVDV1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Apr 2021 23:21:27 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5147C06138B
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 20:20:53 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id cu16so18544606pjb.4
        for <linux-kernel@vger.kernel.org>; Wed, 21 Apr 2021 20:20:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YmmSdM90pO+sNar6XOrbSuxi/vNNsjBBP9QqUAGRLKs=;
        b=N4rfBPuNckMo+Fl/dEflNtB4rmTU6SHg0TMhaV0iuduYgSiQaUq6hI4moIv83mvcLK
         8i3XJyR/+rQgXenMfAXPOVN2FRqj+oybQNJHs5Vh8onyTvKFr4mUOhbagxlbJ/E/YnJJ
         3SlYXItdKqok6r2OWgFY1wRNX+EowDgvIQZEc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YmmSdM90pO+sNar6XOrbSuxi/vNNsjBBP9QqUAGRLKs=;
        b=QDweKvOkcEmSms3k/eY7aaByGQmS8CM/gqsppvwwtAa4YhJk0PRYtIbLzTOlxjzmwD
         y8Aeir3w53ToaCt1GKQ3pseWznPuIeTLi3y7UHwrBJ5Me/rxrULuKZOHSp+w3RpzyT0S
         1ji1d1OZo7WeiHIX19H/U9RgdDvi0+G24w8jVI+9JibFOwEj74WWKl+xhMBASoFHYpno
         pBk9qdgW3NHebGk/eljLBYXhNBhru9rR/GTM5Uc2x+0XcC7nh0rqzuNPnOelmeiSYOPV
         pQYElO/XMz1LupI+W2kL9MjHzIMDvnlkR5+JkhslsiwBp7D6ypWc4h8FL2yV/t9tNUHy
         49/Q==
X-Gm-Message-State: AOAM531JHLd8U+uE6WnZ+g+XSzpSWa3qEg1tGTq24S1Ee/vOLKqFrYIi
        0WOGKqErGfT+YhxVByN/9ZN+LA==
X-Google-Smtp-Source: ABdhPJxXE21iqS93U9HQ1ku5cSKxhO6e51gwHM/EuN1XMjVT+yzg7TfUzLT6zz0CaK+8lBiRuj7KQA==
X-Received: by 2002:a17:902:7b8e:b029:ec:982d:7a7e with SMTP id w14-20020a1709027b8eb02900ec982d7a7emr1426937pll.55.1619061653273;
        Wed, 21 Apr 2021 20:20:53 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id m7sm552380pfd.52.2021.04.21.20.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 20:20:52 -0700 (PDT)
Date:   Wed, 21 Apr 2021 20:20:51 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3][next] scsi: aacraid: Replace one-element array with
 flexible-array member
Message-ID: <202104212019.4315F80C@keescook>
References: <20210421185611.GA105224@embeddedor>
 <yq18s5bt42e.fsf@ca-mkp.ca.oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <yq18s5bt42e.fsf@ca-mkp.ca.oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 21, 2021 at 11:03:19PM -0400, Martin K. Petersen wrote:
> 
> Hi Gustavo!
> 
> > Changes in v3:
> >  - Use (nseg_new-1)*sizeof(struct sge_ieee1212) to calculate
> >    size in call to memcpy() in order to avoid any confusion.
> 
> The amended memcpy() hunk appears to be missing from the v3 patch.

It's unchanged from the perspective of the original code. (i.e. there's
no need to change it since that memcpy isn't involved in anything
changed by the swapping to the flexible array.)

-- 
Kees Cook
