Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEA43F3AD2
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Aug 2021 15:43:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbhHUNnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Aug 2021 09:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234520AbhHUNnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Aug 2021 09:43:40 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C56AC061756
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 06:43:01 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id bq25so26047020ejb.11
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 06:43:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=uw7aN7lfs0C03Rj2YgAtsSHpPr93tKVvkhtBhU3EaV4=;
        b=KerdWP+OraMwIr7d7Aabo37FJBLYFSdftGQHrpSF4wyg1W0BYjMSH35VqNfHX010Ar
         95MLW3kIG8sF3ctPYbjpFFdG0opV/dMg1LszEKcE0iS4hUDbIgLadtEwz5yajNSNiHGO
         4Jqo3flRJzS1uW4aML7tcMZpAYqR6Sct1fk3hE7S+UmtdtqBeL3COaaCstG3PVOg9RMd
         wWAT105+Nw+d6Z+Oa7bRuy+WZMNhlVRHvmqOrph+cqxB6CKL7ZqsKxnC5xkBhkFClpgg
         iBNKHbemJDGym1Tv48ibzQe/PY+wd2icq0pubPBDUsrA+dtL7qUKD+A4s3lJfu9gaadp
         DpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=uw7aN7lfs0C03Rj2YgAtsSHpPr93tKVvkhtBhU3EaV4=;
        b=VOeAkVUjAov3rynwoKxRGIv5yXpSntlpMtCpkBueWz3KOZ4HY0svX5b8kkdbabq7P8
         4fysEsu/fiBPTMDsaNmdTjAdbV/U4+YYNXd0KOmPZq1Yb+IxLlqhrSq+XMvakAvz01ax
         KfgRATnbkPTDxdWv397tVkfz10xyQz3g+zysh3o5TWcUUuIE8SvwFtBRoQJl8Y9hkaJ4
         D3w1z+WQfpX8OzIOp1KzXQ0FZo7fNXK19UjOkSMlwYlLeZRBdSRg2OO8NYIYXESWilMf
         o8r3/4eAsv8MCk+Hvrqk/sygF8nZgmlvNeSmcMzfUsTuIR336ZYE8jQm9W5Fn+kPHdFn
         AwpA==
X-Gm-Message-State: AOAM531aC8gFkzDA33T458nRROpLJWBL6QowbEs0mOSf3vXtWKvI+tc6
        yZ8Lt38p7xHSNMLJjtQp9UnrEdrN19Z+mg==
X-Google-Smtp-Source: ABdhPJw4a4ealNakkSVx5+nwT+lPRJyOW5E9Cu/ghs/E4xxFF38PC3MXhxoOMOG1nDAGR6eWef2GqQ==
X-Received: by 2002:a17:906:2ac1:: with SMTP id m1mr27111809eje.518.1629553379905;
        Sat, 21 Aug 2021 06:42:59 -0700 (PDT)
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com. [209.85.221.49])
        by smtp.gmail.com with ESMTPSA id r11sm4350877ejy.71.2021.08.21.06.42.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 21 Aug 2021 06:42:59 -0700 (PDT)
Received: by mail-wr1-f49.google.com with SMTP id z9so18355002wrh.10
        for <linux-kernel@vger.kernel.org>; Sat, 21 Aug 2021 06:42:59 -0700 (PDT)
X-Received: by 2002:adf:e3c7:: with SMTP id k7mr3871045wrm.327.1629553378450;
 Sat, 21 Aug 2021 06:42:58 -0700 (PDT)
MIME-Version: 1.0
References: <20210819100447.00201b26@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20210821071425.512834-2-chouhan.shreyansh630@gmail.com>
In-Reply-To: <20210821071425.512834-2-chouhan.shreyansh630@gmail.com>
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date:   Sat, 21 Aug 2021 09:42:20 -0400
X-Gmail-Original-Message-ID: <CA+FuTSdTh5ZuEV0LpZQGngtxAA8-43KqFCBNRMWHqQZxnVKafg@mail.gmail.com>
Message-ID: <CA+FuTSdTh5ZuEV0LpZQGngtxAA8-43KqFCBNRMWHqQZxnVKafg@mail.gmail.com>
Subject: Re: [PATCH 2/2 net] ip6_gre: add validation for csum_start
To:     Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>
Cc:     davem@davemloft.net, yoshfuji@linux-ipv6.org, dsahern@kernel.org,
        kuba@kernel.org, pshelar@nicira.com,
        willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        syzbot+ff8e1b9f2f36481e2efc@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 21, 2021 at 3:14 AM Shreyansh Chouhan
<chouhan.shreyansh630@gmail.com> wrote:
>
> Validate csum_start in gre_handle_offloads before we call _gre_xmit so
> that we do not crash later when the csum_start value is used in the
> lco_csum function call.
>
> This patch deals with ipv6 code.
>
> Fixes: Fixes: b05229f44228 ("gre6: Cleanup GREv6 transmit path, call common
> GRE functions")
> Reported-by: syzbot+ff8e1b9f2f36481e2efc@syzkaller.appspotmail.com
> Signed-off-by: Shreyansh Chouhan <chouhan.shreyansh630@gmail.com>

Reviewed-by: Willem de Bruijn <willemb@google.com>
