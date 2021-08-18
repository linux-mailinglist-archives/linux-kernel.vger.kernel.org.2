Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D6ADB3EF99C
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Aug 2021 06:42:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237705AbhHREmn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 00:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237493AbhHREmk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 00:42:40 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03401C061764;
        Tue, 17 Aug 2021 21:42:05 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id j1so1813035pjv.3;
        Tue, 17 Aug 2021 21:42:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PrQrZKc/IAMvILM3QsNkePQMB6aGjlE85KttN2JuB44=;
        b=sETSbMkxwjEoeaxL/Q1dnZrxAHiM/lNokq8GnmsOWfL2QhLFFbWpVIco+WP+4q/NVn
         fyq62BfZ7Sox3IrRbm09DWoiJNIN0bMw2nh0T2CNMqTa5eFRkB6s+4SS/46BMpqygTZU
         yiFRf4t7Rf/+1gaRHJ5ubZa8GvALS9ZW7vkF1oB81HaazIrC+A4W9+DXSHLhyybNkcqK
         BOrwRzQDctCBjvXshUlKZ/dLNkD2yWab55lLuF3fgYFXlB6xIErycsgZZUZQOI2k9TSV
         F3gEKAMsRHdZ52w11d0mye/z/113FiZrF+oFCQDXwg3CANyyr41In9xpeakGTl+rn0GI
         TXXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PrQrZKc/IAMvILM3QsNkePQMB6aGjlE85KttN2JuB44=;
        b=KqrU+0D1ZE1cM0J0OYsq+4kq+ByWtFaLqv2hqedDldWKPtq15tw7X8nOSrqdvfE9q8
         b01usDFZkRdJzOwK21OYHTX/w0xaFKkvjuqd/ah4NUkVNcTgBIGB1e/7s1F0pwOq/OzZ
         DlIuuWyfChoiaRcGm0kWnDjaKdjGSrtLcJPizuJqcac03/1lzUTW+/A3I4kEPKgSljKX
         oDCk32Ghr4AyOSeEHK+F3q17tBQzU/CTVpc94wiLKb8+9iPrJ1todUHgkIivKCzfDwAo
         UcJQAZLRrtXhotFfpuBZflh/YUlfTs7EjdKcpKXk6EMSeKhiKMubiRYyoqMHBuUpM52y
         T7xA==
X-Gm-Message-State: AOAM530niHtj0y74kTs2E208mcIetJXQdtrpFECB67OJjR7MIgS15zQo
        UIG7bRZZ8RkgutIr5Lqjhsk=
X-Google-Smtp-Source: ABdhPJzFZ1HmH18qv82aAsPOzCdGA6diyDdrUiy2qtTvzVavkRx3jNL1QXSTCoXGPe+XslsJ3XX38g==
X-Received: by 2002:a17:902:ba95:b0:12d:d95d:dda6 with SMTP id k21-20020a170902ba9500b0012dd95ddda6mr3778068pls.77.1629261724649;
        Tue, 17 Aug 2021 21:42:04 -0700 (PDT)
Received: from localhost ([49.207.137.16])
        by smtp.gmail.com with ESMTPSA id b5sm3508976pjq.2.2021.08.17.21.42.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Aug 2021 21:42:04 -0700 (PDT)
Date:   Wed, 18 Aug 2021 10:12:00 +0530
From:   Aakash Hemadri <aakashhemadri123@gmail.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Bjorn Helgaas <bjorn@helgaas.com>,
        linux-staging@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] staging: rtl8732bs: Fix sparse warnings
Message-ID: <20210818044200.tvpr4j5vcaimexsn@xps.yggdrasil>
References: <cover.1629134725.git.aakashhemadri123@gmail.com>
 <YRv3w4y3r84mBjrU@kroah.com>
 <1648303.FNMM0ZEVYy@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1648303.FNMM0ZEVYy@localhost.localdomain>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/17 09:10PM, Fabio M. De Francesco wrote:
> On Tuesday, August 17, 2021 7:54:11 PM CEST Greg Kroah-Hartman wrote:
> > On Mon, Aug 16, 2021 at 11:00:41PM +0530, Aakash Hemadri wrote:
> > > This patchset fixes the below sparse warnings
> > > 
> > > rtw_security.c:72:50: warning: incorrect type in assignment (different base types)
> > > rtw_security.c:72:50:    expected restricted __le32 [usertype]
> > > rtw_security.c:72:50:    got unsigned int
> > >
> > > [...]
> > 
> > This series does not apply to my tree at all.  Please fix up and rebase
> > and resubmit, after reading the mailing list archives for others that
> > have attempted do do this type of work in the past for this issue.
> > 
> > It is not a trivial change that is needed...
> 
> Dear Greg,
> 
> As I've already pointed out in another message of this thread, your tree has 
> already these sparse warnings fixed by me with commit aef1c966a364 (that 
> you applied with a "much nicer!" comment).
> 
> So, when Aakash rebases against your current tree, he will not anymore see
> those sparse warnings.

Thanks for the patch Fabio! Will rebase and work on something new!

Thanks,
Aakash Hemadri
