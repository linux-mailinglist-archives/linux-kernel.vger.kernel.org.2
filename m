Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE3841FB36
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 13:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbhJBLu4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 07:50:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232868AbhJBLuz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 07:50:55 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4CFC061570
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 04:49:09 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id h9-20020a9d2f09000000b005453f95356cso14951271otb.11
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 04:49:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=eMBn4piUa5P7icXaukpkHUzeRwiwiWTIBVzdYRFqAwQ=;
        b=cC21qCmaifBlZHFcvEARG78LO9BPX1c1foQIEO5UdxMFtrJLmWlR/cmMYDKQCWtPW6
         B41aA9eJiEp70PTBsZ4WnK3UFGltFL4ZdMSMo3tlJFkRK6ZtsMKpl0nIyrIPpXbf6Kff
         LwJtQDgST2u2eY8M7SyPAoj/TfzU7gfbfRuISVcz3vYIL5mcNlDQGK5r7VQQ9rg8zGIE
         gUYI65sqqyqu+BOe07G46GOlQaRnf3YK9y27JObgA52k6GvX4RZi7jtQCjL7p1UsgN6w
         BdGu0Ms3t7q2CulJ3IfY10hodVks22aZk7MxxA9kY+7EFN3YjD74LUQI68VNlLkaoRp/
         vCmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=eMBn4piUa5P7icXaukpkHUzeRwiwiWTIBVzdYRFqAwQ=;
        b=Dv2FbuuT31NWo2/QM8OXxOcaUNALfDGZ0DoheyQ1jt2aMEcIcoDUBEvskNb3IewcbQ
         B4DO6P7vItfjS9+KN0Ev+FlHY0e6Wk3OqhyLw/3+o0JwkT1liKCLY7FpaIrycd+f9eEE
         1VbOGb4XbJjYnTZjBJaVcBJFGlB6B7V7DHeMURwZoD3lXWFNn89XAo3xwO6CYd0a5wHl
         k7Nxi/8kLGkvbmt2NfxXKp2WSf2K8QyXu8jNrKWlLPJurkhmi5m5tj3j7GDpA/MGsg52
         PWGpmbSU3BhQY1xRpeLMRPa9u4sNO5wNeegAJyfYaXGX8rX+L9O1gz8XhwBZ4B9zPjlN
         BYFg==
X-Gm-Message-State: AOAM533QtsALHeB5tzdPslxOaPgaqQZb3atn4hfi6JR0+bIumwmszQCz
        miqB+sT1KWjAUXdczoIyf/jxhSdhU1AixGgCvts=
X-Google-Smtp-Source: ABdhPJzU15zjnd8pjBBesQhHVU8TZuuiS/q7uZJHumOlNvkM411j+LPFyrOSBPSU0LzHkEbVF43ZmR7oghM5h15ww68=
X-Received: by 2002:a9d:6c46:: with SMTP id g6mr2343591otq.55.1633175349193;
 Sat, 02 Oct 2021 04:49:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:6c91:0:0:0:0:0 with HTTP; Sat, 2 Oct 2021 04:49:08 -0700 (PDT)
Reply-To: mrsjanedennis1@gmail.com
From:   POST OFFICE <postofficetogo2@gmail.com>
Date:   Sat, 2 Oct 2021 13:49:08 +0200
Message-ID: <CAMPPJo3AObhvTF4PT-4SXvKhw7nOHs5KrQ7auJV5HZbXchUd+A@mail.gmail.com>
Subject: =?UTF-8?B?576O5aW955qE5LiA5aSp77yM6Kaq5oSb55qE5pyL5Y+L77yM?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

576O5aW955qE5LiA5aSp77yM6Kaq5oSb55qE5pyL5Y+L77yMDQoNCue+juWlveeahOS4gOWkqe+8
jOaIkeimquaEm+eahOaci+WPi++8jOS9oOWlveWXju+8n+W+iOmVt+S4gOauteaZgumWk++8jOaI
keW+iOmrmOiIiOWcsOmAmuefpeaCqO+8jOaIkeWcqOaWsOWQiOS9nOWkpeS8tOeahOWQiOS9nOS4
i+aIkOWKn+i9ieenu+S6humAmeS6m+mBuueUouWfuumHke+8jOebruWJjeaIkeWcqOWNsOW6puea
hOWkluWci+aKleizh+mgheebruS4re+8jOaIkeiHquW3seS9lOS6hue4vemHkemhjeeahOS7vemh
jeOAguWQjOaZgu+8jOaIkeaykuacieW/mOiomOaCqOmBjuWOu+eahOWKquWKm+WSjOWYl+ippu+8
jOWNs+S9v+Wug+S7peafkOeoruaWueW8j+S9v+aIkeWAkeWkseaVl+S6hu+8jOS9huS7jeW5q+WK
qeaIkei9ieenu+S6humAmeS6m+mBuueUouWfuumHkeOAgg0KDQrnj77lnKjoga/nuavmiJHlnKjo
pb/pnZ7mtJvnvo7lpJrlk6XnmoTnp5jmm7jvvIzlpbnnmoTlkI3lrZfmmK8gTXJzLkphbmUgRGVu
bmlz77yM5aW555qE6Zu75a2Q6YO15Lu25Zyw5Z2AIChtcnNqYW5lZGVubmlzMUBnbWFpbC5jb20p
DQoNCuiri+WlueWQkeaCqOWvhOmAgee4vemHkemhje+8iDk1MCwwMDAuMDAg576O5YWD77yJ77yM
5oiR5L+d55WZ55qEIDk1IOiQrOe+juWFg+S9nOeCuuaCqOmBjuWOu+WcqOS6pOaYk+S4reWNlOWK
qeaIkeeahOaJgOacieWKquWKm+WSjOWYl+ippueahOijnOWEn+OAgg0KDQrmiJHpnZ7luLjmhJ/o
rJ3mgqjnlbbmmYLnmoTliqrlipvvvIzmiYDku6Xoq4vpmqjmmYLoga/nuavmiJHnmoTnp5jmm7jn
sKHCt+S4ueWwvOaWr+Wkq+S6uu+8jOS4puaMh+ekuuWlueWwh+e4vemHkemhjSAoJDk1MCwwMDAu
MDApIOeahCBBVE0g5Y2h5a+E5b6A5L2V6JmVDQoNCuaUtuWIsOW+jOiri+eri+WNs+mAmuefpeaI
ke+8jOiuk+aIkeWAkeS4gOi1t+WIhuS6q+eVtuaZguWPl+iLpuW+jOeahOWWnOaCheOAgg0KDQrp
gJnmrrXmmYLplpPmiJHlnKjpgJnoo6Hlvojlv5nvvIzlm6DngrrmiJHlkozmiJHnmoTmlrDlpKXk
vLTmnInmipXos4fpoIXnm67vvIzntYLmlrzoqJjlvpfmiJHlt7LntpPku6PooajkvaDlkJHmiJHn
moTnp5jmm7jovYnnmbzkuobmjqXmlLZBVE3ljaHnmoTmjIfnpLrjgIINCg0K5Zug5q2k77yM6KuL
6Zqo5pmC6IiH57ChwrfkuLnlsLzmlq/lpKvkurroga/nuavvvIzlpbnmnIPmr6vkuI3mi5blu7bl
nLDlsIfph5HpoY3nmbzpgIHntabmgqjjgIINCg0K5q2k6Ie077yMDQpBbmR5IENodWt3deWFiOeU
nw0K
