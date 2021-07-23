Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B1A513D3799
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jul 2021 11:19:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234291AbhGWIit (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jul 2021 04:38:49 -0400
Received: from mx5.ucr.edu ([138.23.62.67]:35820 "EHLO mx5.ucr.edu"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232348AbhGWIis (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jul 2021 04:38:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=ucr.edu; i=@ucr.edu; q=dns/txt; s=selector3;
  t=1627031963; x=1658567963;
  h=mime-version:references:in-reply-to:from:date:message-id:
   subject:to:cc;
  bh=11hdfmNQdEcgN5T5M4TZZU7b8pnUY8wBhrlerw8iwXw=;
  b=AvZDVuFMnxnvVpeMgHqdN45FdtGl62T3DGJqAz9uMNsM0gMs2LKVG+Jz
   or/apoBtBcDWTA205K3mnOPmYIugSvrrpkqAInHd9w4EN5ovxkIts2YQk
   Oj6yu91Wxu0jlSmRjRi/Q0qJ4hAuRXZk+69hCgCEm1K1gPT6CzmKLv0O+
   CcJNQfMOu2y/00BZPAJ2wqSuFhqOxoVEN/azTHU0Bwud0Lih0L+9X7oLy
   ZBb5ZkHTT4N0PahdTJ8LgnMYHBPv1XlMKs/6/UlT8G//C9Wx0Gr4SylHf
   o4nnc8ZnWd9CPGrTWjJ+BXwoE6XK/zNQNsXGU/SBxxIuMo9JtDV12Zt/6
   Q==;
IronPort-SDR: ZKifuDv9UDaj/i94yCZyINC0CKXsnJCFTp42ZmY/1C1Py+oa0glJ4hjaOdIp+QFqu+zZe+U1Nk
 BfvHqUj/ekQs810CSRcHptTpmgL/PmbZBouE/DwwtjACKOEDWncaAsXQVbjHWmXI9Q2m8Tex/H
 L8RLaVRH3oHIZgY3PFLWr4tpIHJZkNGEn4VOTgHlZaeIw5lQzo8GTvgzKSwBU1otFosSkMdLv/
 N15Q8TuAR/Yrmgq4wIEdBxEOPRuEde4OGga72+p9Zny/2kkPc37XARh5hQXRQTF59LzH8oIMt2
 4Jqj41WCGltBulQGmgds8zPr
X-IPAS-Result: =?us-ascii?q?A2GiAwCKiPpgf0bYVdFaHgEBCxIMQIFOC4N4bIRIkWqdW?=
 =?us-ascii?q?gIJAQEBD0EEAQGEWAKCegIlNwYOAgQBAQEBAwIDAQEBAQEBAwEBBgEBAQEBA?=
 =?us-ascii?q?QUEAQECEAEBgQwLWQtjgU+BeQYEPYI1KQGDbQEBAQMSEVYQCwsNAgImAgIiE?=
 =?us-ascii?q?gEFARwGEyKFVwWcVoEEPYsygTKBAYJfhUUBCQ1OgRUSfiqHCoZiJ4IpgUuCO?=
 =?us-ascii?q?Dc+h1uCZASDHWMYboFOF4E5AQEBkDGDIYk4ggmdDwEGAoMMHI0uhReLeiuDY?=
 =?us-ascii?q?4telyK7MRAjgVOBfzMaJX8GZ4FLTQECAQIBDAIBAgECAQIBAggBAQKdCyQvO?=
 =?us-ascii?q?AIGCwEBAwmLaAEB?=
IronPort-PHdr: A9a23:SpzcixGPMlQblJjUnidz551GfzBMhN3EVzX9CrIZgr5DOp6u447ld
 BSGo6k31BmSAs6Cs6gMotGVmpioYXYH75eFvSJKW713fDhBt/8rmRc9CtWOE0zxIa2iRSU7G
 MNfSA0tpCnjYgBaF8nkelLdvGC54yIMFRXjLwp1Ifn+FpLPg8it2O2+5YHfbx9GiTe/br9+M
 Qm6oRvMvcQKnIVuLbo8xAHUqXVSYeRWwm1oJVOXnxni48q74YBu/SdNtf8/7sBMSar1cbg2Q
 rxeFzQmLns65Nb3uhnZTAuA/WUTX2MLmRdVGQfF7RX6XpDssivms+d2xSeXMdHqQb0yRD+v9
 LlgRgP2hygbNj456GDXhdJ2jKJHuxKquhhzz5fJbI2JKPZye6XQds4YS2VcRMZcTyNOAo2+Y
 IUPAeQPPvtWoZfhqFYVsRuyGROhCP/zxjNUhHL727Ax3eQ7EQHB2QwtB9ABsHXVrdX1KacSV
 v2+w6rIzTrZbvNdxDDw6YjJcxAhu/6MXK58fdbfxEQ0CgPKkk+QpZb7MDyIy+QAqm6W5PdvW
 uyzkWAosR1xoiSxycc2jInEno0Yx1TA+Ch5zog5O9K1RUp0b9OnH5ZduSGXOoVqT84jX2xlu
 Sg3x74btZOmYSQHy4oqyhDQZvGEboWG7A/uWfqXLDxlh3xlYKqyiwiu/UWk0OHxVcm53ExUo
 iZYk9TArHIA2wDV58OaUPVy5F2h1iyK1w3L7+FEJl07mrTDJp46x74wioITsUPeHi/qgEn2j
 LGZdkEj+uWw7uToeLTmppuFO49siAHyL70imsK9DOgkKAQOUG+b+eOz1L3n40L1WqlFjvozk
 qXBsZDaI9oUprKhDgNLzoou7wyzAjSm3dgCg3ULMVNIdAiFgoT1I13OJer3Dfa7g1Siijdrw
 PXGM6XhA5TMLnjMirbhcaph50NS0wcz0MxQ54hOBr4fPf3zR1f9tMbEAR8hLwy03+HnBc151
 oMfX2KPH6CYPLrRsVCW/OIvJfeDZIsOtTbjJPgq+eTugWU6mVADZ6mp24UYaHSiEvRhOUWZb
 imkvtBUPW4M9iE3VvTnjkGPS3YHa3+0Gak1/Ck2Dp6rF6/EXImmhLHH1yC+SM54fGdDX2GNA
 3f1cM22W/4NIHaDMM9ok2RcDpC8QJVn2B2z4lypg4F7J/bZr3VL/ano08J4sqiKzUlayA==
IronPort-HdrOrdr: A9a23:3/vxm6q5gG1hQqC4jrec9z4aV5oQeYIsimQD101hICG9vPbo7v
 xG/c5rrSMc5wxhPU3I9erwWpVoBEmslqKdgrNxAV7BZniDhILAFugLhrcKgQeBJ8SUzJ876U
 4PSdkZNDQyNzVHZATBijVQ3+xO/DBPyszHudvj
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.84,263,1620716400"; 
   d="scan'208";a="227891136"
Received: from mail-pj1-f70.google.com ([209.85.216.70])
  by smtpmx5.ucr.edu with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 23 Jul 2021 02:19:20 -0700
Received: by mail-pj1-f70.google.com with SMTP id a19-20020a17090ad813b0290175a6c43dbfso1129327pjv.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Jul 2021 02:19:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UZ6nos874yRZpIgf2Vh5xy3KOkgY+nI+yWtvY2gRCVY=;
        b=py/GZxLK4wm1dbQweqDW0anopFxZGYzGbmWuw8Efz3lnPA6ZtGpPHAuur6GiFCWfow
         3Vz/VmlhAfV+mWTzzMay5qsqeem1HAcnDv60iNiDvJVMGQxooUC7ERc/Qczb3hVcuto4
         P3X4+fqcWDvqoeeWkZgT8kCWVAAL58czYbIjFVsIT5w9znThTTUpOD/QxF7bdhDJug6p
         w3r58DknzKtVpW53D2sG8xqBxJgjXcCzDc9winy15GuA19gGB6P0IE/dOxuZ2nHafKhM
         Y1/PJ48gsgMsnpzqpqBSVno69gmET+8fQ8+2mCNm5SNVt08GoskUYQCipLqYtbx6BJvU
         ZLtw==
X-Gm-Message-State: AOAM532JfOxFvXT02asVrSFe4mglDsOZ/+AYqUvPT991rzHfeIliSqZ7
        6wQsdLv/NnqkG2yAdHoQmJBKBeVyQUm8wbKwGw4oflD0H+UaToHcwWO+rk4WuIFZY1v/VP2lmC4
        9EFRpSvU8RqqcsjnJimbt0w0yBtoGlLLGmep/wpFWHw==
X-Received: by 2002:a62:ed06:0:b029:32c:a800:ba47 with SMTP id u6-20020a62ed060000b029032ca800ba47mr3647612pfh.56.1627031959288;
        Fri, 23 Jul 2021 02:19:19 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+WXiuLmnX9MFdAd1e0I+8fQgzAvcb+FLbne5Z5luQOERXOyWsR3539QrgvbRqjef6Dr1euYIuxwFmnSGxjeM=
X-Received: by 2002:a62:ed06:0:b029:32c:a800:ba47 with SMTP id
 u6-20020a62ed060000b029032ca800ba47mr3647587pfh.56.1627031958961; Fri, 23 Jul
 2021 02:19:18 -0700 (PDT)
MIME-Version: 1.0
References: <20210723085145.1ce7ee5c@canb.auug.org.au> <20210723003607.64179-1-yzhai003@ucr.edu>
 <20210723081034.GD1931@kadam>
In-Reply-To: <20210723081034.GD1931@kadam>
From:   Yizhuo Zhai <yzhai003@ucr.edu>
Date:   Fri, 23 Jul 2021 02:19:08 -0700
Message-ID: <CABvMjLQ5PW+cddeYCgiR4xx9dKWVdKsaJLrUYFPMmsOLk+a1HA@mail.gmail.com>
Subject: Re: [PATCH v4] media: atomisp: fix the uninitialized use and rename "retvalue"
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Juan Antonio Aldea-Armenteros <juant.aldea@gmail.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dan:
I updated the fix tag in this version, I would sign the patch using my
full name, thanks.

On Fri, Jul 23, 2021 at 1:11 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Fri, Jul 23, 2021 at 12:36:04AM +0000, Yizhuo wrote:
> > Inside function mt9m114_detect(), variable "retvalue" could
> > be uninitialized if mt9m114_read_reg() returns error, however, it
> > is used in the later if statement, which is potentially unsafe.
> >
> > The local variable "retvalue" is renamed to "model" to avoid
> > confusion.
> >
> > Fixes: ad85094b293e ("Revert "media: staging: atomisp: Remove driver"")
> > Signed-off-by: Yizhuo <yzhai003@ucr.edu>
> > ---
>
> Is your full name just Yizhuo or Yizhuo Zhai?  Please use your legal
> name as if you were signing a legal document.
>
> I don't think you have changed anything in this version?  It's basically
> a resend of the patch from Jun 25?  Please put that information under
> the --- cut off.
>
> Looks okay to me.
>
> Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
>
> regards,
> dan carpenter
>


-- 
Kind Regards,

Yizhuo Zhai

Computer Science, Graduate Student
University of California, Riverside
