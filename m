Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC5D43F69A6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Aug 2021 21:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbhHXTQx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Aug 2021 15:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234048AbhHXTQw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Aug 2021 15:16:52 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 986A7C061757;
        Tue, 24 Aug 2021 12:16:07 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id r2so20720938pgl.10;
        Tue, 24 Aug 2021 12:16:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YHLmpisvPPmsqfFKbNTM3t6hjYciHmUpxzHILT2Qr6M=;
        b=gU7Q1xMS9bXpASw00SR/sNuxtUq3cxwtagSusbZwZ7w0pnTQbMyw9wez96UdAhSYRF
         MxQHZUIiRniZIlUcgYG2OYqmi44v7sW7Ae9dUMfHQpIzmQenxnaJaC4zbj9oSHxmfZSw
         6pwXPAYTeqflPdmH5qCkC89j2Fqbx2Tq7Ot1URjWEnSwO+1SncOypH/VG9RYRbxUkPTy
         gF3sR6j9BQcc8SdP9E5OprwUE0nV+rzzX67Yc9mOtrJeX0m7hwWB4c6BslJk+sDmdSMp
         q9xjsGDrPwx43GLj4RNvCHJlMcPg4IR6HQOLZ8xRlWAZ6V9vbs87GTpdbqWA9qTcEjrN
         awoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YHLmpisvPPmsqfFKbNTM3t6hjYciHmUpxzHILT2Qr6M=;
        b=Q6PmRtMqbrMevGyOtTrfFLiiOWyASU041zJw1lffJ0Zx+Q1xCqZ8NB2uHamOdbt5Za
         J2RbGS3LEjgmUxbggux1i3sLJ59NwWagU/+tO1k4/EDMHJyzeieqeFB6AFX+3jZkUoSV
         FqV4L1/LKXeciEbW30k70Lda7wgsXksDxpTrkV7eDuf9shDAJV6bh0Aq3/TqXdeIiNMd
         i+xUXq+aq1THkM1qJSdH7B662O9f4oOflz1mA3HnSyTmoCq53cnysUe11oACU5GwZ8N2
         YxKjlzCm1ziL3ks63Zm6kk284BlJtii4gAhR2oFnwX+/nLUV+1yzYhnrRPSJ5ef6ohDL
         N/ug==
X-Gm-Message-State: AOAM533KCCLPir/hYDJH4+wQt4dfpzCZ7CzqI34ReFWHyEkccbWWWp5/
        U3Ig9iW2aTSgFNhr7o3CFX0=
X-Google-Smtp-Source: ABdhPJw0fkPKuavJ0rp3BV4R0Ekn+rotepq9ObkbKQuExSuhqwnmPZxk2096J9EciWyi6XQg8+DEAA==
X-Received: by 2002:a62:7c4a:0:b029:3dd:a141:c932 with SMTP id x71-20020a627c4a0000b02903dda141c932mr32208662pfc.68.1629832566863;
        Tue, 24 Aug 2021 12:16:06 -0700 (PDT)
Received: from uver-laptop ([2405:201:6006:a148:428:a9ec:7b61:f80f])
        by smtp.gmail.com with ESMTPSA id u7sm3294327pju.13.2021.08.24.12.16.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Aug 2021 12:16:06 -0700 (PDT)
Date:   Wed, 25 Aug 2021 00:45:37 +0530
From:   Utkarsh Verma <utkarshverma294@gmail.com>
To:     Johan Hovold <johan@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: Re: [PATCH] USB: serial: iuu_phoenix: Replace symbolic permissions
 by octal permissions
Message-ID: <20210824191537.GA6181@uver-laptop>
References: <20210820190306.18149-1-utkarshverma294@gmail.com>
 <YST6XZ/XJkTDm6rV@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YST6XZ/XJkTDm6rV@hovoldconsulting.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 24, 2021 at 03:55:41PM +0200, Johan Hovold wrote:
> On Sat, Aug 21, 2021 at 12:33:06AM +0530, Utkarsh Verma wrote:
> > This fixed the below checkpatch issue:
> > WARNING: Symbolic permissions 'S_IRUGO | S_IWUSR' are not preferred.
> > Consider using octal permissions '0644'.
> 
> Please do not run checkpatch.pl on code that's already in the tree. Use
> it for your own patches before submitting them and always use your own
> judgement when considering its suggestions.
> 

Okay, I will not run checkpatch on the code that's already in the tree.

> This code does not need to be changed.
> 

But using the octal permission bits makes the code more readable. So I
made the change.
But if you don't want such changes, I will refrain from doing it in the
future.
Anyway thanks for the review.


Regards,
Utkarsh Verma
