Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9243C3CBAF3
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jul 2021 19:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231158AbhGPROR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jul 2021 13:14:17 -0400
Received: from mout.gmx.net ([212.227.17.21]:40245 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230506AbhGPRON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jul 2021 13:14:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1626455447;
        bh=Pt36AD0Nu5k0fbxEQXWvyPyfVzFALEn1A5TbDs2AJ7Y=;
        h=X-UI-Sender-Class:Date:From:To:Cc:Subject:References:In-Reply-To;
        b=aEUPHNsvu/d0rzE3QHFPwwMmZ67g8AX0dhU9RnIRFaJFLTXRpA0EWYO8ZIlvBjVAm
         5NSDeqVIGNhOzHXFkBBBh18AgPRfP8UjCW+tWz4uB6yGaO/5bAHRrHTMO/NSVyamwS
         lFS6s6603Dp+uUGY+wWa7H82ReXyo4yqYtvKdGSM=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from titan ([83.52.228.41]) by mail.gmx.net (mrgmx104
 [212.227.17.174]) with ESMTPSA (Nemesis) id 1N1Obb-1l7Cyi1tCl-012oN6; Fri, 16
 Jul 2021 19:10:47 +0200
Date:   Fri, 16 Jul 2021 19:10:33 +0200
From:   Len Baker <len.baker@gmx.com>
To:     Joe Perches <joe@perches.com>
Cc:     Len Baker <len.baker@gmx.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Wenjing Liu <wenjing.liu@amd.com>,
        Martin Tsai <martin.tsai@amd.com>,
        Kees Cook <keescook@chromium.org>,
        George Shen <George.Shen@amd.com>,
        Yu-ting Shen <Yu-ting.Shen@amd.com>,
        Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>,
        Bhawanpreet Lakha <Bhawanpreet.Lakha@amd.com>,
        amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/amd/display: Fix identical code for different
 branches
Message-ID: <20210716155945.GB3963@titan>
References: <20210711172433.2777-1-len.baker@gmx.com>
 <a8f75357ab3bd3b37269e51a38aafa997307570f.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <a8f75357ab3bd3b37269e51a38aafa997307570f.camel@perches.com>
X-Provags-ID: V03:K1:tknC4RB6K2nifhTruEF26tbsJxBnMGIVp9cOt81aQXtyJTmAq9P
 FxIHD6edXVQGIoqmJSP3oZggE8rrQLFwbV6A3cyodIVj5xflnakUjoVI2g7LHo+d3UxHxcQ
 0uy/cPOFnxvMYUWPSPJLBj13KZl4OztMqAjfx64DVk6sEyV8BRimd2ony1C5K7v+NEnQy5t
 JcNfEpDm+ex9IquyfYg/A==
X-Spam-Flag: NO
X-UI-Out-Filterresults: notjunk:1;V03:K0:any4VDceyKI=:CrTU5xcsAMBu/MytkSpvhZ
 34d7pqRxO0i3EdHxsL25V9jpZKEyuZ0kaEqORqOl22dPYPe6K7sr2He5Y1ZwMXeYZeuy9w4LS
 dryS1avqt5WT/KvwipqKd5AdyCod6+mkMIKk4k7RUpB0jHQrm7yLCvw2WGaZnx0dJCi5UYbhe
 GPgrGZJMawNJl7kySUz+8ocF/ab7Brtd4z92ORwHAmZv303TwQCvPt+u/tkXsdSKjzShfXjfd
 Gj8kI9TqyaHyBXHvdQjFbgG1DM4wGlR3fZUjHhkZyZJkDkDImfOdKbsb/dFaR3i15q48CXby5
 Igyi4Ybhq/j5N97qwEsc7Q2gXuv/eHTpEBeAMzx3lyjQpiJqvh8dk7FDv+kocQi0prB0YvKuu
 lLwLwq5vDMr7qmSE7lHjsNj+sj8EXyoDdRjldWQnheBTU9v8MTE99BZrLsEsMukaYvI3jN7Wp
 qv+re+3r5PpWMapK00jEATMHmutsWBw223tUYbzDVeU1HGOX+eGhQCYliPt0HoBaAEWK+fqpA
 ZdzRn8I03x1a+FxzdwwlUHRWX1EvMzJumc2ABxayGARuWtsqjprsAYMOwCPrlO3m8J5aLSQI7
 D+j19+CalgmGVrXU/rU5N+SIYlB+C0m2h57+38ShhSVbfHoAHg+3pFORYG5/ceDXqwUoVNKIC
 22knhhBvQxTDBg5xT7D9dm+vYO4RFJQFb9kyqx62y/LGIUKAhzcMi026X847mbmZr8EvZ9X0s
 3g7FhI+xcKV2jcnWjCQBu7GihRtikkFr2eRNiPe2kAP+G4joEVul3mevWh/rzwd4vqoi3PDaV
 J6TKRkdrx6ARBps5mTCXGoD+tso2CB7bjRxyA9/Etcwbp5AjE+QENz7RwLy9cP5t7smcp89io
 8+32kSRvCMaj2ItjOyQPCY6bzLQqAyDqrT0NkHe2xBoO+1VeK+MSviDdDK794NSKO1kcePQkN
 y5wBO7chBX0oOZDpxEBgJedai5LywrW9gLgjEJcDd/+b5vEm2mX42aoceopgLmhhUfc24qLGa
 ByKA8l+wD1oQQJZlmwLEzqk+gxpvMN7P6npbyrYEKV2FlixHjaWgeRNi/nXxUsrfp5VfYpQuk
 ZrXfMHERgT5JXyZcvsqv8iSKWsGedi8guRB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 11, 2021 at 10:45:48AM -0700, Joe Perches wrote:
> On Sun, 2021-07-11 at 19:24 +0200, Len Baker wrote:
> > The branches of the "if" statement are the same. So remove the
> > unnecessary if and goto statements.
> >
> > Addresses-Coverity-ID: 1456916 ("Identical code for different branches=
")
> > Fixes: 4c283fdac08ab ("drm/amd/display: Add HDCP module")
> > Signed-off-by: Len Baker <len.baker@gmx.com>
>
> I'm not a big fan of this type of change.
>
> It's currently the same style used for six tests in this function
> and changing this last one would just make it harder to see the
> code blocks as consistent.
>
> I doubt any reasonable compiler would produce different objects.

Ok, thanks for the review. I leave it as is.

> > diff --git a/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.=
c b/drivers/gpu/drm/amd/display/modules/hdcp/hdcp1_execution.c
> []
> > @@ -305,10 +305,8 @@ static enum mod_hdcp_status wait_for_ready(struct=
 mod_hdcp *hdcp,
> > =A0				hdcp, "bcaps_read"))
> > =A0			goto out;
> > =A0	}
> > -	if (!mod_hdcp_execute_and_set(check_ksv_ready,
> > -			&input->ready_check, &status,
> > -			hdcp, "ready_check"))
> > -		goto out;
> > +	mod_hdcp_execute_and_set(check_ksv_ready, &input->ready_check, &stat=
us,
> > +				 hdcp, "ready_check");
> > =A0out:
> > =A0	return status;
> > =A0}
> > --
> > 2.25.1
> >

Thanks,
Len
