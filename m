Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381A345716B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Nov 2021 16:08:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233950AbhKSPLA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Nov 2021 10:11:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbhKSPK6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Nov 2021 10:10:58 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC6F7C061574
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 07:07:56 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id l25so27491629eda.11
        for <linux-kernel@vger.kernel.org>; Fri, 19 Nov 2021 07:07:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=xcbP3+Z+4opqhqz2YrhDD9WgRy4WRH7Dd6BeosfSlcg=;
        b=IhZIEKq1PhYlO3UQ0CMAP6YnTPUtGCaaAsqMb5MpxLsmK+dXhhuDixX8ZrqiZ7mCO7
         jKwxkabTHeHAkUljMOMUbWQa2zUZ2DGC9tWohMFlKHiutJkO2MqcOmQ5RV4RdZJVfcFp
         ovFeghbjKKPT8oHEIH+Quu+4obISrNfE+avhuffkGL7Kl4AG+f7ZIy2XOvkpbT8XGJHj
         V4waodwSB6AJ4L/sDvxcgm6fmnP/OJauNoDw5P3xilELPGsJawea1tgDtRTsFBXLBWwN
         r8EQJ7/IpMTM8wyx/fY3t/CKMQ/JiXfoSG/sERresvEjpeXyOzCrlZB7vm92q4qkwWcL
         9+7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=xcbP3+Z+4opqhqz2YrhDD9WgRy4WRH7Dd6BeosfSlcg=;
        b=KzWW+RRfm8uApn9d+FzBwiGzz66F5ShMDWlfON76gwy2/MNe6ga1bU6ELCXOIGICvi
         1apuNfacoguNAuhA4jtrgpgXJ6TGrlPshR9jX1lFJZe7EMYZzi0nJlLLjNtl8pQMdu+F
         BLfRPb1T35jSZEIGLK7hAkokyg5GEh17RUUQDrHOjjK+X7bRpRdiqNnQ+tagmbD3PKjL
         XXs3gkKCgBv27IHmiyXck3Mt60TKN131dnGAt+bhcj6Z6vq8esZOxEdVpOigdqhrr8JF
         +91stNLb6oFygP1qGKWUJCAIoOOJc1PsQEnT9FWs9NDlsnOA2LhzeTKwEtOkM+lOp3Zu
         PRyQ==
X-Gm-Message-State: AOAM5338F+BPovxQrjDMItBFvNjq02oajCCJwh2QXeopyTpJcntLZ4Aw
        19Si1xz5lnrxnVgHifi8Ng==
X-Google-Smtp-Source: ABdhPJyyrUhncdkCYDN8GlfAjj/281JiF6S/cu7pm4u+YDHHbzsKPPW53tJFrKoIk24PnvYtbK5YZQ==
X-Received: by 2002:a05:6402:40d3:: with SMTP id z19mr25778073edb.185.1637334475480;
        Fri, 19 Nov 2021 07:07:55 -0800 (PST)
Received: from localhost.localdomain ([46.53.249.210])
        by smtp.gmail.com with ESMTPSA id i10sm62777ejw.48.2021.11.19.07.07.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 07:07:55 -0800 (PST)
Date:   Fri, 19 Nov 2021 18:07:53 +0300
From:   Alexey Dobriyan <adobriyan@gmail.com>
To:     Alejandro Colomar <alx.manpages@gmail.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/17] Add memberof(), split some headers, and slightly
 simplify code
Message-ID: <YZe9yYBvE038/w90@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +#define memberof(T, m)   (((T *) NULL)->m)
> +
>  #define typeof_member(T, m)	typeof(((T*)0)->m)

No.

Your macro exists already under different name.

sizeof_member and typeof_member exist, you don't anything more.
