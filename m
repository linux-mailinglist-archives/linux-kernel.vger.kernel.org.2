Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 834C73F36A2
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 00:48:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234317AbhHTWsu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Aug 2021 18:48:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbhHTWst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Aug 2021 18:48:49 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6566C061575
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 15:48:10 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id f10so6760918wml.2
        for <linux-kernel@vger.kernel.org>; Fri, 20 Aug 2021 15:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=philpotter-co-uk.20150623.gappssmtp.com; s=20150623;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=g7ZjB0kpmQk/BmDkEZAy3iHp85Ka80jxWVGQUzXwpdQ=;
        b=xq+Cmew/0c+qC6oazsVxH2SIoq8IQvqlQ/WQwyY2SQyByvDbQzMWNVkgakr2iSNv3O
         I4M3f84zp9+fNyptuUurGasJ/oIVeqACRZiWY+kGc4YUmtd5LrP4rL5ztq2rmnbl9qbK
         LCzUFVMx5YjyOYH4JXVA8tcaCKW+lYlbxefOa1D2ORqpSQCq4fxHwsTXaKOr4D5yb09s
         yTbxTzK7cIVfirgr2qNl8UxcdqgsnnFlqM27wSmGrSZHvqWwsl6NrONy6dxILyrmWORF
         QrbbiEnNjWINqSMvSvSjpl1O3z6/Lr8BNhzP88UrrXDbaOlMWFVXa5Nyo4RZZ0hStjXz
         Yktw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=g7ZjB0kpmQk/BmDkEZAy3iHp85Ka80jxWVGQUzXwpdQ=;
        b=BbGjoAVa15ZposLrIy5cacOrRnU5YrIlGQLyBSVsEI5m3a5KqNU5OH0jZo/koKz+8Y
         Zava0djjptuiIaYX0S0HtnvmypBJDC5tlQcDbFNdBNyNyTloiUQKXEPBuPro9h/VfnqR
         B1E5L0JUWd4LGbiDv99fHTqFna5jrUaGezf+aSLbigfInAdYMqpj0RrUpKu5ju38VXWD
         h+hwSTvHlUQOKrqg0SkcqYv63j3aIxfA3DqD8cXeqrZVH8foebvLX2jW3It22JbDKoIX
         afVxXKvuN/yy5U3k0+9uQ5w7CvmIGNvuP2/KdKT+RUsR0o7PA2DK1AHH2lOnjO9gXt0v
         Izfw==
X-Gm-Message-State: AOAM533tkmgo+r5vwcZ5MSdxuv6bz+ppuCEoVbfqMGa99FGF7PeOWloj
        8OZeoNFq78P3wIXQsDn25ougpw==
X-Google-Smtp-Source: ABdhPJyhrUsxC9Gz+ERvH9s7biHU1OcSsOShSbLFERwJbTpV/8hyLzlV10zkXkBYKuHJdIcP34+4Xw==
X-Received: by 2002:a05:600c:2281:: with SMTP id 1mr5960766wmf.9.1629499689361;
        Fri, 20 Aug 2021 15:48:09 -0700 (PDT)
Received: from ?IPv6:2001:8b0:dfde:e1a0::2? (2.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.0.a.1.e.e.d.f.d.0.b.8.0.1.0.0.2.ip6.arpa. [2001:8b0:dfde:e1a0::2])
        by smtp.gmail.com with ESMTPSA id a11sm7341504wrw.67.2021.08.20.15.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Aug 2021 15:48:08 -0700 (PDT)
Message-ID: <693326266015233ecdebb0df9ae06a76748f6137.camel@philpotter.co.uk>
Subject: Re: [PATCH 2/2] staging: r8188eu: remove unused function
 rtw_remove_bcn_ie()
From:   Phillip Potter <phil@philpotter.co.uk>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     Larry.Finger@lwfinger.net, martin@kaiser.cx,
        fmdefrancesco@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org
Date:   Fri, 20 Aug 2021 23:48:08 +0100
In-Reply-To: <20210819112200.32030-2-straube.linux@gmail.com>
References: <20210819112200.32030-1-straube.linux@gmail.com>
         <20210819112200.32030-2-straube.linux@gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-08-19 at 13:22 +0200, Michael Straube wrote:
> Function rtw_remove_bcn_ie() is not used anywhere, remove it.
> 
> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
>  drivers/staging/r8188eu/core/rtw_ap.c    | 38 ------------------------
>  drivers/staging/r8188eu/include/rtw_ap.h |  2 --
>  2 files changed, 40 deletions(-)
> 

Dear Michael,

Looks good, thanks.

Acked-by: Phillip Potter <phil@philpotter.co.uk>

Regards,
Phil

