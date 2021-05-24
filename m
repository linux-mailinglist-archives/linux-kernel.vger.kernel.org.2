Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4287F38F263
	for <lists+linux-kernel@lfdr.de>; Mon, 24 May 2021 19:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233552AbhEXRlh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 May 2021 13:41:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233509AbhEXRlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 May 2021 13:41:35 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20EDAC061574
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 10:40:06 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id j6-20020a17090adc86b02900cbfe6f2c96so11562671pjv.1
        for <linux-kernel@vger.kernel.org>; Mon, 24 May 2021 10:40:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=sTMdfl7490EUvFpi8+cM20l+2QkFa8OjDn3LY3LnB8g=;
        b=n8fH/VMbgfd6cRp/TQjx3U196IeCN0qxIEAi6w1Ejs/HL3HtQn8A4RC+PkbAaJ7YXx
         v2DYyU6k6hdak4BbLALW0lx0Tpf3yWbHUeoCnJhdtcnFVicNtqGCbErlV0W80aibgVLo
         qcq7Kx3+j8rl6PWfSyH9cYgLp4BLtao7OZ96GjGyG3Xwuh4IygxcgZk4TJHUOM3tMe72
         jrlBH5ugkQvAvRSHx4zN54AWLITw8/UCnoTZFv+pwuBnPrX5Q+/XgabEUZf6Mw+mibNE
         nOe3pHgoUHfkkH5OAClqOiO0MZpeQtS4tQ/Dy7ZuIpCZkZRp/KzZPuEOqtc+NVlQ6lbr
         p1wQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=sTMdfl7490EUvFpi8+cM20l+2QkFa8OjDn3LY3LnB8g=;
        b=TJa9HhcQzGqgjw7ZGYIPTmdqUxlyOsFLsXScGCfuZC0sYiMf2c43S45W2Lp3rpgKMj
         Ni5woOMu3e5oXABmbyzGFGTFedW/YfYQyH3qXT34QdO/ExARst1cnuaFlHJEJ/STERGl
         YWC+bEg8ox3VMPS2tAVzoz6YlSmDpK+sT19zjv7NvnDv4DxdeCq0HG9x3N0XoU6UeT+5
         iwHLquBaaOKYyovIFWo7GFEztKxOeC5qJnWP7YoOfq4wpwMXRDWDp48vg0wFcW1lAdBy
         2bhUkU4PtcXZFaHoA0aCXyRsGgA24ea62fowpgpzsIs9TGZQcH91KxsuAs1KDfZvUM7m
         u0zw==
X-Gm-Message-State: AOAM533PmOHSwuaqzxsW5pFZc3dFSr0mo6YxasEpQ1gIWw7zIxC/4pN6
        qrq/ez6COsltSi7O233//xU=
X-Google-Smtp-Source: ABdhPJxfF9PCeKa3cCzxFrqVmh9I5Uyn2fwwsnMG8kDEetRGWiF1peoAFvUuRdAj+8civkPVDk3VWw==
X-Received: by 2002:a17:90a:f518:: with SMTP id cs24mr292344pjb.182.1621878005779;
        Mon, 24 May 2021 10:40:05 -0700 (PDT)
Received: from hyeyoo ([183.99.11.150])
        by smtp.gmail.com with ESMTPSA id n28sm5193454pfq.139.2021.05.24.10.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 May 2021 10:40:05 -0700 (PDT)
Date:   Tue, 25 May 2021 02:39:59 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>,
        Vasily Khoruzhick <anarsoul@gmail.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: line6: Improve poor error handling in
 line6_init_cap_control
Message-ID: <20210524173959.GA116743@hyeyoo>
References: <20210524173644.GA116662@hyeyoo>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210524173644.GA116662@hyeyoo>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

added an error handling code. It builds well,
but I don't have the device. So please review it (and test if you have one)

if you think I can improve something, please tell me.
I'll send v2.

Thanks,
Hyeonggon
