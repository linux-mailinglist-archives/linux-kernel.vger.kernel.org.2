Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EC0F630FCEF
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Feb 2021 20:35:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236970AbhBDTcF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Feb 2021 14:32:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236851AbhBDOw2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Feb 2021 09:52:28 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFC98C0613ED
        for <linux-kernel@vger.kernel.org>; Thu,  4 Feb 2021 06:51:47 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id z6so3797842wrq.10
        for <linux-kernel@vger.kernel.org>; Thu, 04 Feb 2021 06:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=1tKBbIR4fWGNy/DkjznXmDcn30clccCwDDnQOymnr5o=;
        b=lowTAP/p6H/c5T3jDMEClUYbkbotY60JVGaI4ih0IGq5VPn6yxxxQO+B62cZoMjiBl
         cv/HDKI2E4eQfXZsqaWD0iNTxO5wWBOFmgzWpR4FnZPir1hrncJjB9P9uhcEv0ivfiRW
         cf4FN7n9dg7Vf2Xqg8s0qYBUQ/sUA8eDK1T5wMLsORUsSMzp3kJWoHIbB/xKm87/bAKp
         zkiQW9MlF3ZXAlZC9sQ055QtC0X1wQOakhzbCjPsb1HlrIGtHjy2hZMmcien12IC7Ki3
         rgUA+6vlbS6ErQXr1G1k6rdFvivBJtX4PnduA9sm6C816RnKiKEspYSq3F/3Zp5k8lwM
         9b8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=1tKBbIR4fWGNy/DkjznXmDcn30clccCwDDnQOymnr5o=;
        b=PHFTrwVQSDXlznVAPihUjvcce4X/u0St4LAVIGklhZI5SHrEhAiIWpwwrou/5pT0DG
         6bFwPxHF0UHyUiUrD2m6MsiKrB+N+5Quw3AMGtjdblwpHEoiSnFFIl7QGuleutQCW9qQ
         LkwGIntc+VGF0gXWyb760wXekgwgacNd5TiQXt1cYxdhAJwMz/XWtrkVWEA65LNWZlqv
         s2p+NTFfb8VbFTVpEd75J0raPdLxvMCktRHkpqecEX447gMGHDDBlxT8nV7GwtpWL5Lx
         y634LUrfsu9ZjXTInsQRc6InKQz1B6r1XPQdogvg2fquK4X4TY9tFVRcgcWEjIbt9L3y
         utSA==
X-Gm-Message-State: AOAM533SglWCzmGAzQnKok8DbV/ZQiA5fCfAjHS2psCX8ZWQs4Lw/U65
        EKvIWduiZK/gKxNuC0Lj7Ew=
X-Google-Smtp-Source: ABdhPJyVuSUWI6KjAL+pvJkLiegbo19gHvRJIW+dOyxIj8aGroNo8CIzFM4Hx8Sei42qQMHh5e61Vw==
X-Received: by 2002:a5d:538b:: with SMTP id d11mr10047459wrv.334.1612450306719;
        Thu, 04 Feb 2021 06:51:46 -0800 (PST)
Received: from LEGION ([27.255.58.138])
        by smtp.gmail.com with ESMTPSA id n187sm6323450wmf.29.2021.02.04.06.51.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Feb 2021 06:51:45 -0800 (PST)
Message-ID: <3d1f36ebd3b59788a586e55bcaaad9705ecca4be.camel@gmail.com>
Subject: Re: [PATCH] staging: rtl8192e, rtl8192u: use correct notation to
 define pointer
From:   Muhammad Usama Anjum <musamaanjum@gmail.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
Cc:     devel@driverdev.osuosl.org, linux-kernel@vger.kernel.org
Date:   Thu, 04 Feb 2021 19:51:42 +0500
In-Reply-To: <20201028044232.qtzsnrrh7xgdzsoc@ltop.local>
References: <20201026121435.GA782465@LEGION>
         <20201027112303.GA405023@kroah.com>
         <20201028044232.qtzsnrrh7xgdzsoc@ltop.local>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.36.4-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Sparse's warning is not about changing the definition of this member
> as if it was the argument of a function. It's about how can you use
> an array of structure when this structure has a flexible member.

We have the following structures in drivers/staging/rtl8192e. (I've
simplified them for showing here.)

struct rtllib_hdr_3addr {
	int a;	
	int payload[];
};

struct rtllib_info_element {
	int len;
	int data[];
};

struct rtllib_probe_request {
	struct rtllib_hdr_3addr header;
	struct rtllib_info_element info_element[];
};

static void func(struct rtllib_probe_request *ptr) {
	ptr->header.a = 1;
}

Running sparse gives: 
sparse -Wflexible-array-array flexible_array.c
flexible_array.c:13:48: warning: array of flexible structures

There are several such structures in rtl8192e and rtl8192u. I've been
trying to fix one of them. But it seems like more knowledge is
required to refactor the driver.

Thanks,
Usama



