Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23A72352B3A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Apr 2021 16:09:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235734AbhDBOGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Apr 2021 10:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235675AbhDBOGm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Apr 2021 10:06:42 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF8FC0613E6
        for <linux-kernel@vger.kernel.org>; Fri,  2 Apr 2021 07:06:41 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id b14so7714019lfv.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Apr 2021 07:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=mKbc9afm8xBaI2xSQPLm/UX/B7x6iZLPtOaC/+DOWEQ=;
        b=bYtPZn/0JZjdIeyzbrelE+V1zFyh86oxMIjeqrtCjuqOikDDqYc2D44n8yGWZDSKtp
         8klD2zpkPihH/LhDtW3CBgWcZtmh58YozjIHc2l1U0t6dMtnXT83k0biVFX76WjPWcGa
         jiGR/hGln0TpZ5FrqCZz0L/dZqWH2DcvGMVCbwkl1TCFOwJIOure+6tMMhMSnp1fybpI
         aMBHKKtGjyXvBrhB8UgQYGtELvZk7ghNeIN01Td0+5ORJpY5yTWOp5Xo17yOzmzl+kdI
         niwZWaxLYPO/EjVQGiuL9GIh70k3kuWDpgEbouuMW4hAVdWWdlzyCwVEXvRtCaQJ6FGX
         Za2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=mKbc9afm8xBaI2xSQPLm/UX/B7x6iZLPtOaC/+DOWEQ=;
        b=QJCyPo9RmQPsBH3zhHXf4kw60toR1HxKNebt9sXJqQTWvzVd6Csk7b4jHG95zfUPoO
         vZVIQI1ObdnGoVKLnbWbMf9EptoZ6Dr3CmoEGkS5LtlzeDSz2sMS7HMicp6QrYgtOEVM
         YYh5MDu8kIqBG4gFxZwzRQeuhjtQUyjMCE70oOSNxlfWS75rrJj91BI0HXzbt5ua9dDf
         2NdheYvC4/XnAhBe/I3MGvNT+9QteXt3rEaDmOKlwCq+IPc2jTo2EcFQHTzJOiMixcoD
         UH32auFQFTSLGuilxG1LnnpTyw4hFfPQLutNBqWlLODhuCjw9pnuXvB43gUCq9UKBRE3
         gJ3w==
X-Gm-Message-State: AOAM530RxGL0tdiqNp57ec1b9utp7GuQSa9yJaCi36PcgDgN0KrJ9GRG
        kcXURHv0+cwb0nu+9LBkc9KUgN/rs7UJq5Y2yys=
X-Google-Smtp-Source: ABdhPJw4BO2XC1NvB5N3dcsWysruc4oGOK/Jy60SNYw1CeFnM7ySyTR8IKBrEOv8FyKD6R93Bxs3+qKlSFlfph0UEEc=
X-Received: by 2002:a05:6512:308b:: with SMTP id z11mr8690344lfd.487.1617372398708;
 Fri, 02 Apr 2021 07:06:38 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6512:3d22:0:0:0:0 with HTTP; Fri, 2 Apr 2021 07:06:38
 -0700 (PDT)
Reply-To: stephenbordeaux@yahoo.com
From:   Stephen Bordeaux <chineduoscarchukwu@gmail.com>
Date:   Fri, 2 Apr 2021 16:06:38 +0200
Message-ID: <CAK2=jhaknCY5hKCkGOh_Uck48iBAwM4qAbKnxqfN5iP0NTipiA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dobry dzie=C5=84 Nazywam si=C4=99 Stephen Bordeaux, prawnik z firmy prawnic=
zej
Bordeaux. Skontaktowa=C5=82em si=C4=99 z tob=C4=85 w sprawie maj=C4=85tku z=
mar=C5=82ego doktora
Edwin, kt=C3=B3ry mia=C5=82 zosta=C4=87 przeniesiony na twoje konto. Osiem =
milion=C3=B3w
pi=C4=99=C4=87set tysi=C4=99cy dolar=C3=B3w. Ponadto w tej transakcji chc=
=C4=99, aby=C5=9B
odpowiedzia=C5=82 poufnie. Stephen Bordeaux
