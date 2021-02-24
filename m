Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C73BA32413A
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Feb 2021 17:05:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235981AbhBXPo3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Feb 2021 10:44:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234454AbhBXP1m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Feb 2021 10:27:42 -0500
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9936C061786
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 07:26:45 -0800 (PST)
Received: by mail-ot1-x329.google.com with SMTP id d9so2439000ote.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Feb 2021 07:26:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=0tINuWbSEFlsmm2CKCil1o30jokMKilD2EtRa6Qgnk0=;
        b=WdenylQ0GwphWigbjgjo1IgIuny3VeVRKIt//ezrTg8siOvciRrt6z9b03KIv0BL2O
         +GsTnl3nlmedNZTIeoHvkSdYVGIMcpORsbr88OT2vLzJlpgR8hNM3VwfqyhOZXOX5eIM
         zybItsvmn0ZMfhLLetZh5dBZS8MpFGvQfEQhTw55X/pSwZqs6QKlmbpOtaTHJvvzsOe0
         JvcIc1ck/wx4bb6YZLweL0ZXPAraqmYI6yXw2krf2nCx7tvJXcSj7mIj8p84Msd7ZWRH
         qr40IwmofnIADlK30tWOJTC1KnTmVxDVEA3Gvi4HPm/7go2nWCHpWIB5ru4ygoVi6Tnn
         6S+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=0tINuWbSEFlsmm2CKCil1o30jokMKilD2EtRa6Qgnk0=;
        b=PCR5XAtrBSP69Nm/b2MsFbW4QnYOQGl+/9DjME40r1b8OzmhktehnX1Jayg2Jrm+iU
         MxbW+h1jqUddTcXvYLu/KvYeF5RaiPbAwYsCU1m9UPcSYk6Xj3ODINsAZPm2UOxrlWEU
         mT925sxAXCL7/sFjGrjrOBM7IBMezzdd3Wjl5au+EREPX82w9yl2LLea2bz+EBcvapEN
         hfbkR8d8oark/tzd+DsfF4d6FMive+HZRAYeqUPCqiZRnaTN9xhigcirzqXiR6/V+ej7
         Gexlo1KTWLetsaSNNI8otaOawQd5n7vj/EUwf8NMqJNoN9yoQTHIvezFN4VlhPnCE6TW
         lTEg==
X-Gm-Message-State: AOAM532Rfoxx3AwMnvviqB8edD++Mh+IVecXl7/EKsV18VTsZkBEI+F+
        y8AUG8veFGcTqu+Hhdy+XmKikKDRl7sYMVW0z/E=
X-Google-Smtp-Source: ABdhPJzLFjDohtQxsaRJ9YNVGYjPS6huFSoRPonVEnMqW+s3x4Ticp0HCJcIHb8XZrmWZBEt/RjiFr8sRPChHj1zQ04=
X-Received: by 2002:a05:6830:1646:: with SMTP id h6mr25343863otr.267.1614180405304;
 Wed, 24 Feb 2021 07:26:45 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6830:4115:0:0:0:0 with HTTP; Wed, 24 Feb 2021 07:26:44
 -0800 (PST)
Reply-To: infottcuckk@gmail.com
From:   Tom Crist <mrjames567890@gmail.com>
Date:   Wed, 24 Feb 2021 07:26:44 -0800
Message-ID: <CAMzQy2cKX33dv3SBH=vjVJgiW=UP_JNe1T5m8RT1xGCEDOfRuw@mail.gmail.com>
Subject: Re:
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

LS0gDQrQmNC80LDRgtC1INC00LDRgNC10L3QuNC1LCDQv9C10YfQtdC70LjQuyDQkNC80LXRgNC4
0LrQsNC90YHQutCw0YLQsCDQu9C+0YLQsNGA0LjRjyDQvdCwINGB0YLQvtC50L3QvtGB0YIgNDAg
0LzQuNC70LjQvtC90LANCtGJ0LDRgtGB0LrQuCDQtNC+0LvQsNGA0LAg0LIg0JDQvNC10YDQuNC6
0LAg0Lgg0LUg0YDQtdGI0LjQuyDQtNCwINC00LDRgNC4INGH0LDRgdGCINC+0YIg0L3QtdGPINC9
0LAg0L/QtdGCINGJ0LDRgdGC0LvQuNCy0YbQuA0K0Lgg0LHQu9Cw0LPQvtGC0LLQvtGA0LjRgtC1
0LvQvdC4INC00L7QvNC+0LLQtSDQsiDQv9Cw0LzQtdGCINC90LAg0L/QvtC60L7QudC90LDRgtCw
INC80Lgg0LbQtdC90LAsINC60L7Rj9GC0L4g0L/QvtGH0LjQvdCw0LvQsA0K0L7RgiDRgNCw0Lou
INCh0LLRitGA0LbQtdGC0LUg0YHQtSDRgSDQvNC10L0g0LfQsCDQv9C+0LLQtdGH0LUg0L/QvtC0
0YDQvtCx0L3QvtGB0YLQuCDQvdCwINCw0LTRgNC10YE6DQppbmZvdHRjdWNra0BnbWFpbC5jb20N
Cg==
