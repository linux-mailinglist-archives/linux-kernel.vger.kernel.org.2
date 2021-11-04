Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD3B444BD9
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Nov 2021 01:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229928AbhKDANa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Nov 2021 20:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbhKDAN0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Nov 2021 20:13:26 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9C3C061714
        for <linux-kernel@vger.kernel.org>; Wed,  3 Nov 2021 17:10:49 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id b4so3789534pgh.10
        for <linux-kernel@vger.kernel.org>; Wed, 03 Nov 2021 17:10:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DZ3jPl3PPBYENWWpmyV11Z/WC/C6R82IpL6uLEjtT0s=;
        b=WKGq3m1WuqQbJD72bygTQI77zDusyeC2AMh9QymuD45i7wluG1pnjJ8EpWY1xth0ov
         eWcV+U30NOhDH5YZTmYwkPHCEZHzbcRmbxUQXNRHmpg4RwMcfsbQlZynWuNTVftXpZTJ
         LAh2yP8cDQLVQ18fQydTSR6ykGEFNjkWgpGU4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DZ3jPl3PPBYENWWpmyV11Z/WC/C6R82IpL6uLEjtT0s=;
        b=BKlBdItv/SbS1BtjT0KqsktV0t/wiCGWmKXY1/PD5tb3v4PLaZ3T+Y+t2Vz7EIkjh3
         R/WyvHNbWnJsWUE1WQcXeW2edLRsEx0HrQ83L62Ach4htLl3pGl2zAa9uUPbRKt6rvLD
         K6iKITbtkiPTPU0BvijOK8W0Fa5lcuwF4coGkyEcUOyl+eVdwlUksGu6F6rxPUDr+X4l
         AMfZAdoPoFmm8oCCcdt0JH+qyBZZaA93m4p4f5wVrbAtBvcUibsI4oZR292leyQyqRAm
         zSmV5/0yBVxcfegqjxE09HjD/5slr5l9FDwrZ8oIwI9RyDVdxK8YtT/QCrRf/N3SzcoG
         NX4A==
X-Gm-Message-State: AOAM533jv7GOBJcuAWLdsU1NbJIFXlz2NdYzcyNMVJ9QWxYg+W5LZcy0
        eoOwb8W8bfIpklpzSMa+FbWcvBnTxlgkvg==
X-Google-Smtp-Source: ABdhPJyfZf9MlDRaAZHY7ketZgyOwuXeEM5a2jZNaLLAx7WzPNmwByDZEJM6t0JG1nZEKh7ZlUIKJw==
X-Received: by 2002:a63:d644:: with SMTP id d4mr24808925pgj.360.1635984649365;
        Wed, 03 Nov 2021 17:10:49 -0700 (PDT)
Received: from google.com ([2409:10:2e40:5100:1f56:281c:d78b:3f3a])
        by smtp.gmail.com with ESMTPSA id h10sm3712340pfh.2.2021.11.03.17.10.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 17:10:48 -0700 (PDT)
Date:   Thu, 4 Nov 2021 09:10:44 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     Guo Zhengkui <guozhengkui@vivo.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steve French <sfrench@samba.org>,
        Hyunchul Lee <hyc.lee@gmail.com>, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@vivo.com
Subject: Re: [PATCH] ksmbd: fix flexible_array.cocci warnings
Message-ID: <YYMlBCuhyqgdVHiC@google.com>
References: <20211103131901.28695-1-guozhengkui@vivo.com>
 <CAKYAXd8dd83NoCetj+-Cza5EnTvSZXBbu4UWR0WHT5YjAD-05g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKYAXd8dd83NoCetj+-Cza5EnTvSZXBbu4UWR0WHT5YjAD-05g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (21/11/03 22:51), Namjae Jeon wrote:
> 
> 2021-11-03 22:19 GMT+09:00, Guo Zhengkui <guozhengkui@vivo.com>:
> > Fix following coccicheck warning:
> > ./fs/ksmbd/transport_rdma.c:201:20-27: WARNING use flexible-array
> > member instead.
> Is there only one here? It would be better to change them together in
> this patch.

I guess I see more than one

fs/ksmbd/ksmbd_netlink.h:       __u8    spnego_blob[0];         /*
fs/ksmbd/ntlmssp.h:     __u8 Content[0];
fs/ksmbd/ntlmssp.h:     char DomainString[0];
fs/ksmbd/ntlmssp.h:     char UserString[0];
fs/ksmbd/smb2pdu.h:     __u8   Buffer[0];
fs/ksmbd/smb2pdu.h:     __u8 Buffer[0];
fs/ksmbd/smb2pdu.h:     char   FileName[0];     /* New name to be assigned */
fs/ksmbd/smb2pdu.h:     char   FileName[0];     /* Name to be assigned to new link */
fs/ksmbd/smb2pdu.h:     char FileName[0];
fs/ksmbd/smb2pdu.h:     char   StreamName[0];
fs/ksmbd/transport_rdma.c:      struct scatterlist      sg_list[0];
