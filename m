Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DFC442CF47
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Oct 2021 01:43:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbhJMXpb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Oct 2021 19:45:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbhJMXpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Oct 2021 19:45:30 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801F4C061746
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 16:43:26 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id d9so16776509edh.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 Oct 2021 16:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=70WgJz68301W4YAWeUnEt0QpDAyQBF+Qn8eRADlWcZg=;
        b=tZA9wgJTf8LhUZogPP5QfxAXUuLBr2snIF0TIThAd0bHlqMQg/8FW01FUEIuqdBi5P
         sqOZmZsU9vrBPGuqMaXAwnnljLuKj+cCGBSN5KqI+oDmc7+7Mc4ivT+v2zMVGgbnqY6R
         6x+HYqb8EoKh7wvACzBGViDQp2DNhIu/rhZnE+uIsNc/ysxbBZsoRoBAVuVEq7tg/Dcu
         aUtNBspxTrzkAV8rhuJaKqGKRPdfAY18gY2iZvVF3SGv63AMGLwsW6VrGTrsMb0u0MWT
         O/O4fkqgv4o4JsR0n/2hco/6stuJ4d1sWpMRRAH0k/Ela+yIYHNedsfxDn+eMaud4bhM
         /4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=70WgJz68301W4YAWeUnEt0QpDAyQBF+Qn8eRADlWcZg=;
        b=SotULebAE8XDqX4hIT+EpU4v2O+tobG9CMAqaNp69W7nCBBHpyMYmq3OPGxC6OgJvz
         mCtrI4bj54jaBqQ0VbK3wwKVBmirV2Fl78qtmO0Pb2D5m9YRFehyZ69i2bsV8DfqtKDu
         5BRcRiBqlsMrLpxeVPVL9W5GEPFRs/LaZRi76Znh+4ZY9OMQHlA8KemQc6sKXai/8/Kj
         +74DP86D82zuf+r6BcNfRWOPjAgZpm7AEeTl7k7/2xmVAXS59Swk6RA6FKYSTUEFKIfG
         JBtr6XybrONH1HlL9dqUwP0R8mp5v+C0CGOgzKyOuUlvUlrhgS0jCfHOdX4Man67YRuz
         h4jg==
X-Gm-Message-State: AOAM5313azL7hFS3L9sLNcqrfpOuvvUWPGJl4hxhJX0JVAA9ualTvms3
        PXxQOFs4dyTpAJbuR2mQxYjHygUG3obm/aL4uqAEpw==
X-Google-Smtp-Source: ABdhPJxUMstUt73PfXbllHC9NHBVobh37BXe7qV1Bk73wDAlJ9lF1d+353wJ5XQjmhvwV9GfreivHf/BEnZFxTyfbZg=
X-Received: by 2002:a05:6402:34f:: with SMTP id r15mr3664494edw.111.1634168605027;
 Wed, 13 Oct 2021 16:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <20211013143810.2101838-1-arnd@kernel.org>
In-Reply-To: <20211013143810.2101838-1-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 14 Oct 2021 01:43:14 +0200
Message-ID: <CACRpkdbbZo1VUk1yBWuuEswiThf5Vrbgq0SFo07Z_FMy4vvibw@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: versatile: remove leading 0 on unit address
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Liviu Dudau <liviu.dudau@arm.com>, SoC Team <soc@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rui Miguel Silva <rui.silva@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 13, 2021 at 4:38 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> dtc now warns for the LED nodes on the versatile-ab board:
>
> versatile-ab.dts:126.12-132.5: Warning (unit_address_format): /core-module@10000000/led@08.7: unit name should not have leading 0s
> versatile-ab-ib2.dts:17.12-24.5: Warning (unit_address_format): /syscon@27000000/led@00.4: unit name should not have leading 0s
>
> Remove the extra zeroes.
>
> Fixes: 07ebfa59b9db ("ARM: versatile: add the syscon LEDs to the DT")
> Fixes: 7fbe5f7ff267 ("ARM: dts: Add Versatile IB2 device tree")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Fair enough,
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Can you apply/send this directly to the SoC tree?
I don't have any other changes for Versatile this merge
window.

Yours,
Linus Walleij
