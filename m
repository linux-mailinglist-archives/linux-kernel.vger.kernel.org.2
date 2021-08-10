Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E7CDB3E5931
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Aug 2021 13:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240138AbhHJLiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Aug 2021 07:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbhHJLiC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Aug 2021 07:38:02 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6EDC0613D3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 04:37:40 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id gz13-20020a17090b0ecdb0290178c0e0ce8bso2682197pjb.1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Aug 2021 04:37:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=I0gGCvRkAlv8daRNKce4CyetI+GPLvWb/ziVhwHGreo=;
        b=e9iTeBTWzCjVpfrbF8GaYL2Uob0LcAdfZ3vwiA24LeW4gLJrih2kgonFcLDM8vDp5l
         zgOwj69hQBIO7ea9tVggeDAbg2DPMI1G8TQQJvA7m+WLDevk0BsCGouiYaZ83Ke6KXQ8
         1sc4xjKb60xP8lNI/KhxLPhMbcZJN3wgTVfOBC8f9YCPWcl2h1EQTQ6QV1KsJmnE3y0V
         7UR0IDt9M3xC8lJ08mWLcfLra4PIjBZXwdN6I8ZXV0bQcpjhtcoFz+VnJIhjQFcNGCPu
         C9uhHegdOQSmkxKiCQNQbxtSAIN15LKhauI8YzZ80hcH7RvfhJkFM/yuukEzQEGy6gTE
         sE/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=I0gGCvRkAlv8daRNKce4CyetI+GPLvWb/ziVhwHGreo=;
        b=ATh0OE+64/0acnZkjV+j+ewNl/XVx7WvUvstgpNTiUmmf5w92Ex4fxn6OZaz32BN5H
         NxCfEy09/RNWass7i/x1VtWs4nbMEX/0VBqasC0dwL9BFQzcSOM6jzY1YWOMyh6uqjZ5
         RTs9gsRn5/ipNTsq/xpWa8tRyfqyNJ0ojcVKOJCuY1/FQZTl5G3xHQSiEwKEhBEXtEjA
         SjW0sinddxP+1Z1WhFQj09dB67AjJJSbSCttMx0iqMAKqjuv/kKAs2y02SakfMcFqT9n
         VKA1Tvp8jjUlbbockCXeDgZecpcKlxkHvMi2g5StMmNiPanvtx8g5G/vAidthH/cuuwd
         csTw==
X-Gm-Message-State: AOAM5302JY/DCuh0JBl6MZvaGMQ6CfW8vDFALy8/ijCAqvDlVJmzLuWQ
        Bz3w7n/mGGUtfZggwG42b0RB5lyKb/ks0RfhQKo=
X-Google-Smtp-Source: ABdhPJyKdkcUlEOrmQ/NVATmyWskU1AZ+Mz4I6M0on4YtZ5uGaCIXfkzPsNm+GQuZhavgqTu0yUZNLzHHaP4M1Sdfp0=
X-Received: by 2002:a63:131f:: with SMTP id i31mr195650pgl.207.1628595459698;
 Tue, 10 Aug 2021 04:37:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6a20:1119:b029:4c:7ce7:61b5 with HTTP; Tue, 10 Aug 2021
 04:37:39 -0700 (PDT)
Reply-To: barristerbengazzarak@gmail.com
From:   Barrister Ben Gazzara Kekeli <bgazzarakekeli@gmail.com>
Date:   Tue, 10 Aug 2021 04:37:39 -0700
Message-ID: <CAMivQX+_Fpj2SSm1Meop15Wi4aR-XhpVsCSrd1NAn5hJeB0p2Q@mail.gmail.com>
Subject: =?UTF-8?B?15TXmdeZLA==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

15DXoNeZINee16fXldeV15Qg16nXlNeT15XXkNeoINeU15bXlCDXmdek15LXldepINeQ15XXqtea
INeR157XpteRINeR16jXmdeQ15XXqteZINeY15XXkT8g16nXnNeX16rXmSDXnNeaINee15nXmdec
INec16TXoNeZDQrXm9ee15Qg15nXnteZ150g15vXk9eZINec16LXlteV16gg15zXmSDXnNen15HX
nCDXodeb15XXnSDXqdecIDMuMiDXnteZ15zXmdeV158g15PXldec16ggKNeb16HXoykg15DXoNeQ
INeX15bXldeoINeQ15zXmQ0K15vXmSDXlteUINeT15fXldejINeV15TXmNeR15XXqiDXlNeT15PX
mdeV16og15XXnNeS15nXmNeZ157XmSAxMDAlLg0K
