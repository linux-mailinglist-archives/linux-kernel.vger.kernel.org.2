Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C663D3F0FDB
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Aug 2021 03:12:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234903AbhHSBNK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Aug 2021 21:13:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234322AbhHSBNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Aug 2021 21:13:09 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E04C0613CF
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 18:12:34 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id a126so9037349ybg.6
        for <linux-kernel@vger.kernel.org>; Wed, 18 Aug 2021 18:12:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nqKgp+4kxeKkHkpWnGTM9/4lqTjTkLI36sNXKnaG3TE=;
        b=JBEnpVFqoKYSQA9YnCm98t4kD/T8yn6Snef5hlnqkSyLEfkdROTDgKG3Dh3D5FBxqq
         buZHhQY54IxSI+aBiyJoEG/BGpiVVRl16/YqGMfN26HbbN9+8p1jAyZf2EozMK+2yuNz
         3zDm3iSQcEoujVUAxXgADZUKOqXKmdGrl6qW7cGdcUrHUGWFgMtSF1Xe5F7msswgTC4d
         8NIaNudNZ1miRxmh7FifUu3NQa9GvVA+03rXTiA5HEn8FjZQZjYcgF2DjESpIWoz/IPc
         VR5HJJF9sOBAPq43t/nXoBum3cQnfOA55lUK5F8sA8QSiGT1K7L+psI41eyAQB+O/Rje
         e2gA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nqKgp+4kxeKkHkpWnGTM9/4lqTjTkLI36sNXKnaG3TE=;
        b=P9pJygTxbKPEAsSqRVHwEKATmC7V80tZ1IE9F4eOgR+n7nKgMO9eEXnaVOyzHxBM0x
         0dR/lLx2AhuwtLfFrJBDCa72COBd3L1V/9M1ombbwz7u2KDPNaK9ce3BFMh9qUPBYXQ5
         8la6yHyEA1EU+oZsUJpkBc/qwno8dfJ/PDRm9r1zNN5lYTAmNTG7ewbplwiiordeVHBV
         VtcHv9jygrgOJkDmMZr7PSI6nZuvCAaP3tPmOPTbO1EPKl+XMAULs1rGZHTqFaHZKCkf
         WtKAx7fudyzlnrzFo7ITEbzVLjE/7BeF3V2/PMAVQzpQLziRvXNAApcqxNJwVLv+aqTa
         ynUg==
X-Gm-Message-State: AOAM531B2cefR0zBIlP6nIPt3LTIlTG//n6XQtBSubhQwjjXP+pq68TN
        5Qp0alHlW9zhsVelB5kG37Y8Fb4l+GvZKzXC3m/fJg==
X-Google-Smtp-Source: ABdhPJyp7jXNQMocIf1VjjPKDk9B2vOcnnDh1bOIyGr6K3siuuocY301BduvWApFIPG1/MRVHSVgetKaX2kPzR4TDDc=
X-Received: by 2002:a25:c056:: with SMTP id c83mr13242178ybf.228.1629335552976;
 Wed, 18 Aug 2021 18:12:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210818130950.3715-1-Wentao_Liang_g@163.com> <CAL_JsqLfvfi42QGkM_WqKUm0GPZ6z=ybBz9kaR5UakKd0mzGEw@mail.gmail.com>
In-Reply-To: <CAL_JsqLfvfi42QGkM_WqKUm0GPZ6z=ybBz9kaR5UakKd0mzGEw@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 18 Aug 2021 18:11:57 -0700
Message-ID: <CAGETcx-C1avGdGLS=X7pc-q3u_BZv7wJwMWEJ6KFbDYYafeP2A@mail.gmail.com>
Subject: Re: [PATCH] drivers:of:property.c: fix a potential double put
 (release) bug
To:     Rob Herring <robh+dt@kernel.org>
Cc:     Wentao_Liang <Wentao_Liang_g@163.com>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 18, 2021 at 7:07 AM Rob Herring <robh+dt@kernel.org> wrote:
>
> +Saravana
>
> On Wed, Aug 18, 2021 at 8:26 AM Wentao_Liang <Wentao_Liang_g@163.com> wrote:
> >
> > In line 1423 (#1), of_link_to_phandle() is called. In the function
> > (line 1140, #2), "of_node_put(sup_np);" drops the reference to phandle
> > and may cause phandle to be released. However, after the function
> > returns, the phandle is subsequently dropped again (line 1424, #3) by
> > the same put function. Double putting the phandle can lead to an
> > incorrect reference count.
> >
> > We believe that the first put of the phandle is unnecessary (#3). We
> > can fix the above bug by removing the redundant "of_node_put()" in line
> > 1423.
> >
> > 1401 static int of_link_property(struct device_node *con_np,
> >                                 const char *prop_name)
> > 1402 {
> > ...
> > 1409     while (!matched && s->parse_prop) {
> > ...
> > 1414
> > 1415         while ((phandle = s->parse_prop(con_np, prop_name, i))) {
> > ...
> >                  //#1 phandle is dropped in this function
> > 1423             of_link_to_phandle(con_dev_np, phandle);
> >
> > 1424             //#3 the second drop to phandle
> >                  of_node_put(phandle);
> >
> > 1425             of_node_put(con_dev_np);
> > 1426         }
> > ...
> > 1428     }
> > 1429     return 0;
> > 1430 }
> >
> > 1095 static int of_link_to_phandle(struct device_node *con_np,
> > 1096                   struct device_node *sup_np)
> > 1097 {
> > 1098     struct device *sup_dev;
> > 1099     struct device_node *tmp_np = sup_np;
> > ...
> > 1140     of_node_put(sup_np);  //#2 the first drop to phandle
> >                                //   (unnecessary)
> > 1141
> > 1142     return 0;
> > 1143 }
> >
> > Signed-off-by: Wentao_Liang <Wentao_Liang_g@163.com>
> > ---
> >  drivers/of/property.c | 1 -
> >  1 file changed, 1 deletion(-)
> >
> > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > index 6c028632f425..408fdde1a20c 100644
> > --- a/drivers/of/property.c
> > +++ b/drivers/of/property.c
> > @@ -1137,7 +1137,6 @@ static int of_link_to_phandle(struct device_node *con_np,
> >         put_device(sup_dev);
> >
> >         fwnode_link_add(of_fwnode_handle(con_np), of_fwnode_handle(sup_np));
> > -       of_node_put(sup_np);

Hi Wentao,

Thanks for noticing and reporting the bug! Your analysis is correct,
but the fix is definitely wrong. For one, the reference to the node
phandle is pointing to can be dropped in of_link_to_phandle() when it
calls of_get_compat_node(). It could also be dropped in one of the
error paths. So, now you'll be incorrectly dropping the reference for
the wrong node. Let me send out a fix and  mention you as the
reporter.

Thanks,
Saravana
