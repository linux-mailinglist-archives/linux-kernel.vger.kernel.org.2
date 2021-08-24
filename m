Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5155E3F595A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 09:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235010AbhHXHs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 03:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234969AbhHXHsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 03:48:55 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70449C061575;
        Tue, 24 Aug 2021 00:48:11 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id x4so19007058pgh.1;
        Tue, 24 Aug 2021 00:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=B3hQaZ5ORQMoz4CCAkI30BUWirzjOBvm7urDWULbWbQ=;
        b=S8wae+Cm7KQ0oz0TBIQHrlOaWDyBSNfMbGC0rwjMOGsN6pwh4ocA7w/zQV2CNac8EC
         W5g7vkbhANy7LhccPm7uAbt4qzpJJPxPpH2cdSatG3eMmX0vRWhricHcRc868lcBIdXG
         3+a7bjf/coMT6tmm7L0ki+yIzNiWXBK8IMDCg6jSG8Uf+sW/UYfuyiBGW0qEwLRJU8M8
         VxTnDfHJaHuXh3OzlHVF1Dno477AvluEV5oIcUsNMV99JamJptdavgO3eBvmt8H8rZtL
         96jYmE82ja//lfSe9c4PMZSmKMmu6c6k2ZVWCD1R2tPJRTTaVih6dmfjbylfKibZlUd8
         ri0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=B3hQaZ5ORQMoz4CCAkI30BUWirzjOBvm7urDWULbWbQ=;
        b=lqrZIkmNCgdZEEHhYmjx5eEAZt8Szd6zd7lXd5AEWjwjxVCMslTfAwWK26yvCEz5gX
         9nbN9JywVinuHpmgfmWtBrsP9RN4JiXoC6p8k7OywUFfzg79f+UAjzpnG8ywSt7ovTHw
         Wc5IXu0JWLtBWJROQnOEhIwOA1bQ+/zMUyjtKorakjR0P4eElwOGM2N42tl0WBtC1Pcx
         bBCXFFwqvosun4LldRken3E2qhUt8RPtWXUUX3N1mrPcIXdZx3JwcAUqG6PInMV4DnAe
         8ijVs35MQVFKjB7BdHCbd3279lXI+zVtCaujge8nqaNa/0V5PN54A4/CS3gGOEvOmKid
         2low==
X-Gm-Message-State: AOAM533ekKfbZtl77L0PK7xEBo9urWD63NUm75lMeM3G8ideeJNKsGv+
        t00TQTQNg0iVo9v2t/3o2utqapYrb9Skd6NWEeM=
X-Google-Smtp-Source: ABdhPJx4ng34Xy4WoR/xFCYy/YHed0mgmj3F6o3zE9O4ix8neySH/Gw4ig9ph27LIA1EsGViKfcVsiKKzbZC4tWnqDU=
X-Received: by 2002:a63:1e20:: with SMTP id e32mr35751311pge.108.1629791291013;
 Tue, 24 Aug 2021 00:48:11 -0700 (PDT)
MIME-Version: 1.0
References: <20210822143204.224282-1-junhuahuangdream@163.com>
In-Reply-To: <20210822143204.224282-1-junhuahuangdream@163.com>
From:   teng sterling <sterlingteng@gmail.com>
Date:   Tue, 24 Aug 2021 15:48:00 +0800
Message-ID: <CAMU9jJq-z0qkX=-60zFqyP=YdUFyqY8WJWTWZZyPdREBB-uD5Q@mail.gmail.com>
Subject: Re: [PATCH v2] docs/zh_CN: Add zh_CN/admin-guide/sysrq.rst
To:     Junhua Huang <junhuahuangdream@163.com>
Cc:     Alex Shi <alexs@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
        "Wu X.C." <bobwxc@email.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Junhua Huang <huang.junhua@zte.com.cn>,
        Yanteng Si <siyanteng@loongson.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Junhua Huang <junhuahuangdream@163.com> =E4=BA=8E2021=E5=B9=B48=E6=9C=8822=
=E6=97=A5=E5=91=A8=E6=97=A5 =E4=B8=8B=E5=8D=8810:33=E5=86=99=E9=81=93=EF=BC=
=9A
>
> From: Junhua Huang <huang.junhua@zte.com.cn>
>
> Add translation zh_CN/admin-guide/sysrq.rst and link it to
> zh_CN/admin-guide/index.rst while clean its todo entry.
>
> Reviewed-by: Yanteng Si <siyanteng@loongson.cn>
> Signed-off-by: Junhua Huang <huang.junhua@zte.com.cn>
Hi Junhua:

Some warnings were generated during the build process, if you can fix them:

Reviewed-by: Yanteng Si <siyanteng@loongson.cn>

BTW:

* It is best not to pick the Reviewed-by tag until the reviewer
voluntarily signs it.

* Perform adequate testing before send patches.
     build it, --------> fix error and warning.
     checkpatch.pl <your patch>, ---------> fix error and warning.
> ---

Thanks,

Yanteng
