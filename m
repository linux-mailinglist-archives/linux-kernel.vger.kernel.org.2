Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C2B73AFB5A
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Jun 2021 05:20:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbhFVDXD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Jun 2021 23:23:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229546AbhFVDXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Jun 2021 23:23:02 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0515C061574
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 20:20:46 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id c7so20730981edn.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Jun 2021 20:20:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ingics-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=2Y3kxYWIW4quvbRBWVIa4fOTtu3njJrE0ioG5Cnm9xw=;
        b=HPi7X8T9CasaITW/jUJjxLRhkWdwkQNQrBfN1vAqPMjdru+JLx+Rw8E/JaR13H5Q67
         52bAG/0AGgve29yQcp8/F5qb3LyLfA6dC8qjBJjyCkSaEjHp0kxw51yuevwku/LYGM6K
         cV8g9Ozrwjt/G23a7G47fSoAotklzYM/A/gXtO6D79HnYznPD2yu8u7c7K0Yvcuto60B
         GT3pBa8uqSxbE/uvrYVTYZQOgMA0fgiMJwnYpDt69RPM/w+v6MiHGGmB1ByALf+yFhgX
         RW+ValM3O2h9YY7AFOLLHno/noK1vIDi4JmRiFhLo7uGd2nAEZuwUl1Ko2EbA7AxaUYp
         HTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=2Y3kxYWIW4quvbRBWVIa4fOTtu3njJrE0ioG5Cnm9xw=;
        b=GlCij9ZkvDrmeFmWWnAfr6rX++4zwPmtLZr6bopNXej188RYhycO65clX60C/vJVkc
         aV2jLbzAThDYeT283iOoxqpDlpqE7n3kvOw1QNIcy0q2Qh5kdf5KEjg67y5ka8HJU3KF
         gBeUVEIcAG6eg9VeEh7+hXQo7QNFwdL07exxtX/mv5or8Lt5XoF5TwfZEbRlFEiHO3BS
         hIafeMjYKaw7Z1UkTWu0W6UO4kzNpSiRA9WiLBiYk+yvTIC6UNmZumWdH3P1faBSX/Uu
         z0qHV4AOxbKvBDOdXR26JuUE27Qr90cOTYxNVi769jcKZ70pjttiJnARbysV69YePIQ5
         5qSA==
X-Gm-Message-State: AOAM532A/9rIxeh8mF/sgqosrIih/OG4v6mpb044Wq9cVdbZQPI/soKn
        0eO4oKwohm6ZiJf+ZNZL2bI7mIHqrL8B27b3EVOXFA==
X-Google-Smtp-Source: ABdhPJxexFGiesaUIzw789uWimHXBM+EirSkbrzXS9xxVRdsot99ivsgjTBpP4uF4ttrCTRKVS4osvetmloDXc3JIzw=
X-Received: by 2002:a05:6402:1a47:: with SMTP id bf7mr1940303edb.236.1624332044744;
 Mon, 21 Jun 2021 20:20:44 -0700 (PDT)
MIME-Version: 1.0
From:   Axel Lin <axel.lin@ingics.com>
Date:   Tue, 22 Jun 2021 11:20:08 +0800
Message-ID: <CAFRkauDjKaEmtEoUH94wkT0Xd9-XL3NOYyvB3haYVT+BrAK-Dw@mail.gmail.com>
Subject: regulator: mt6358 vdram2_idx/vsel_mask/ vsel_shift setting seems wrong
To:     Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Cc:     Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hsin-Hsiung,

In drivers/regulator/mt6358-regulator.c:

static const u32 vdram2_idx[] = {
        0, 12,
};

MT6358_LDO("ldo_vdram2", VDRAM2, vdram2_voltages, vdram2_idx,
           MT6358_LDO_VDRAM2_CON0, 0, MT6358_LDO_VDRAM2_ELR0, 0x10, 0),

With current setting the vsel_mask does not match the vsel_shift setting
   So in set_voltage_sel, it will call regmap_update_bits with
   mask = 0x10
   val = idx << 0
   No matter idx is 0 (pvol[0]) or 12 (pvol[1]), it will clear vsel_mask bits

I don't have the datasheet to check, so please help to double check the
vdram2_idx, vsel_mask and vsel_shift settings for ldo_vdram2.
I think at least one of the settings is wrong.

Regards,
Axel
