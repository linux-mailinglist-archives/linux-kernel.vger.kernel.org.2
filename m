Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C7D2322578
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Feb 2021 06:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231266AbhBWFkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Feb 2021 00:40:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230486AbhBWFkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Feb 2021 00:40:13 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D3DC061574;
        Mon, 22 Feb 2021 21:39:33 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id e9so9164541plh.3;
        Mon, 22 Feb 2021 21:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ks1JpMmrpygrrg+OwQcvmd1lav3Eez6m4FiRHRvDzpQ=;
        b=noFQnsaaSW5PQAQrBFzhweUGjI5W6GRhLk/AoSoTlbttn/w5sL6pSCVi/buLw0Jblj
         hVWITdEoGsHLkFRkbRdeQytUmklXf68vajkR9z5JsMZ++d6lQRmRFXoEBn2lBDwCfYe/
         5TRs5i5026fC7R6sfKEQqsVAOUF/vj9k/1lmVqFQ25mrvUkwRt8jp/9CcxJYJPvDyY4Z
         PYY7p953ZyWlVd0aTEdSO1L4nacjRbsxBfett8hnjOBOsK0MiRy2JsA/7qiHyTafT+3H
         Uez1brLn/PJnZPY8CMK0dJdpqJPMgECsEKzVQ9dl2O8PbYyEfgjF8UrQwaglpD3oQezo
         WEwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ks1JpMmrpygrrg+OwQcvmd1lav3Eez6m4FiRHRvDzpQ=;
        b=py2PVdpAgnly7gb054U5iCkUMnOY4Kd+2pMD/B4mzJzaJo9flCI0R1vlOdG/4As47M
         QwjTS3qtQlaYihA/+MatgKPmRVjvaYNwodcb6ysGfjZDfHzdJn1rzv1Do1RTB7FkLiAT
         a6GLztRrsM3ubd6uE4kG8ayMzMziaJ7HACaS0PkvpX2Ofzyrjt9CPTMUwNjd7ICrzhy+
         dtjmcAItCaMue5Vhm9ly4qbeHbbHQA2NJZfqDWxxTNiJvsZhDZUVDyK0LnaGHQikdNpT
         eiN+2AkXAxmWeeTdG0SSOKGlqfN57Ty+JPv1ekURCnXTiS4MW01Oichc2zAUNBEayr6e
         uaGg==
X-Gm-Message-State: AOAM531POPzEVYpM4IQuvmwkDJcTJIgnbHL5AU8cle0i10wD9wyTWMjF
        MFg3N6Qge7nuCIAqiAj3dLIumFmoz44=
X-Google-Smtp-Source: ABdhPJyfxkaS4FFQezNS+krEwe1ao6zCZY7birkuxyjFdgT0WcgwPOAfPEjgZjneTgKrul1qtZ/ZsQ==
X-Received: by 2002:a17:902:f688:b029:da:a817:1753 with SMTP id l8-20020a170902f688b02900daa8171753mr25514149plg.76.1614058773010;
        Mon, 22 Feb 2021 21:39:33 -0800 (PST)
Received: from google.com ([2620:15c:202:201:bc19:4f46:855:edfc])
        by smtp.gmail.com with ESMTPSA id b15sm20247968pgj.84.2021.02.22.21.39.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Feb 2021 21:39:31 -0800 (PST)
Date:   Mon, 22 Feb 2021 21:39:29 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Philip Chen <philipchen@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, swboyd@chromium.org,
        dianders@chromium.org, Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org
Subject: Re: [PATCH v6 2/3] ARM: dts: cros-ec-keyboard: Use keymap macros
Message-ID: <YDSVEWr6XgeuchL7@google.com>
References: <20210115143555.v6.1.Iaa8a60cf2ed4b7ad5e2fbb4ad76a1c600ee36113@changeid>
 <20210115143555.v6.2.I9ec9c3c61eded22a5f7fbff838d23fc95ec7cfe0@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210115143555.v6.2.I9ec9c3c61eded22a5f7fbff838d23fc95ec7cfe0@changeid>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 15, 2021 at 02:36:16PM -0800, Philip Chen wrote:
> The common cros-ec keymap has been defined as macros. This patch uses
> the macros to simply linux,keymap in cros-ec-keyboard.dtsi file.
> 
> This patch also creates an alias for keyboard-controller to make it
> easier to override the keymap in board-specific dts later.
> 
> Signed-off-by: Philip Chen <philipchen@chromium.org>

Applied, thank you.

-- 
Dmitry
