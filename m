Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8430A3F9F56
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Aug 2021 20:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbhH0S56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Aug 2021 14:57:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbhH0S5z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Aug 2021 14:57:55 -0400
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB13CC0613CF
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 11:57:05 -0700 (PDT)
Received: by mail-pg1-x535.google.com with SMTP id y23so6674390pgi.7
        for <linux-kernel@vger.kernel.org>; Fri, 27 Aug 2021 11:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:sender:from:date:message-id:subject:to;
        bh=DXQ3lYRd+RJrWBWKlHG0BfrppwGOELJIQ4taDI2QXC0=;
        b=iSmLuQnIamnOyJeu+Uda+TLpzEI+2EJI7QxFe4oIhNh6FKYSuDG4O6beHaw3/+V7Gr
         WQTRXL5oPJDYXzNVTVjoPe7DZ5x2G3QidWDtTgb7Ny0sVMQflwMwvBHZv/1giY6vrsSP
         I4LuL2z29s1L4dQY9/hyOljG0uqhP5BleZcVX3gCJ33lSoDdD+y1sQTpcvFV1r7G4Jr9
         c0kocY4no1yf5+WZL1hW/4MQ8fWbH24RlzmNgsVAY4RPdvSlDT5xLMaKvuL7u0MBv/V/
         SLbXDqcoXpg+w3TtvHBIM4CM0hrOXpQc7+WeBdtSkeL0v6Xh1r/BmFgb6XdTBSrLKSlr
         JpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:sender:from:date
         :message-id:subject:to;
        bh=DXQ3lYRd+RJrWBWKlHG0BfrppwGOELJIQ4taDI2QXC0=;
        b=g9asuMe9k2SI6eL63MvCbBuZIQM6/azXtN4UO9C9hZwPuCklQkVnCvMp6TBSEyZbZg
         QuVtKyKEtbbI9dvNwxGPgo63ClxfcVKSIlW6tcEVEnD0Y+I1YPhXuihwQUoqkobBKjL3
         /qyRJvqkrdSOK4CCiGRJnFmAYpm/pZ27RX5Ra/ryxllTjJwA9VkXjd6gGjTSL+SdkWOB
         2Gfouwnuxm2s6kyoZntmVbSbK8oZHim38NYEWVppW+NfPshXpjZSZ2selVsxWtGqV8Di
         FJeDSSXo2MkuhyGeIV1nH6w/5BKglfSSu/7IMDebrcQf6qnDgSVB+ZH8pS8v7GumNYMf
         DGJQ==
X-Gm-Message-State: AOAM533GjbiTKzhqHflAKYJ5qq6mejvDpgaIAPstPk+ETp8ImKWjQf2n
        8pNNKcKZJVyJcuJiHHK1I4HBYTufn1cBgNfok+w=
X-Google-Smtp-Source: ABdhPJwpDAGgy23CS8nKiDzewxwOu7qWqCtigY+4/2mGC+nnNcACa+ekYmloaWPgG+LaurntC0Ci77HkskdKzxruQaQ=
X-Received: by 2002:a62:5c6:0:b029:341:e0b1:a72c with SMTP id
 189-20020a6205c60000b0290341e0b1a72cmr10513214pff.71.1630090625274; Fri, 27
 Aug 2021 11:57:05 -0700 (PDT)
MIME-Version: 1.0
Reply-To: mrs.chantal778@gmail.com
Sender: menlight2@gmail.com
Received: by 2002:a05:6a10:c7c7:0:0:0:0 with HTTP; Fri, 27 Aug 2021 11:57:04
 -0700 (PDT)
From:   MRSCHANTAL <mrschantal737@gmail.com>
Date:   Fri, 27 Aug 2021 11:57:04 -0700
X-Google-Sender-Auth: _9C-Lj39xHW_RS9KI-SyUW3tJEI
Message-ID: <CAA-qcAV5yYUNdZh+-3uRjjepXOWPZh+c5=GuH6FwrPP9zP1f=w@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

-- 
You have been compensated with the sum of $3.8 million dollars in the
United Nations, the payment will be issued on the ATM visa card and
will be sent from the Santander bank.

we need your address and your whatsapp
this is my email address (mrs.chantal778@gmail.com)

Thanks
Mrs.Chantal
