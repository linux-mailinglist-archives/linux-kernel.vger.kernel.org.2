Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EED8E40AEDA
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Sep 2021 15:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233172AbhINNZ2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Sep 2021 09:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbhINNZ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Sep 2021 09:25:27 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F930C061574
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 06:24:10 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id x11so28960493ejv.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Sep 2021 06:24:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZQjOz+ZZ81Ebb5EPtK1mTpOLbzJJlm8KGTxpSWS8pc8=;
        b=qYtqhg8m/O1lCKQKsabfArcZaRMY9k0MxVOLEDIImkDyUsUQcqwHHYO3I02wBagofO
         g4CJ/CkaQ9MYKHhK1Rag/COMV7aWzBYyqjJ/K8yWDgmTxN6vWtVqSXW4rqCw31LJk3sJ
         NnNrvc1fTaNlGNXvlnHoz8jMfd9P9qz2PVblm26V7Il1wOAsfmACxLqqUFVHkGPa0d0K
         occNgReCGrIz+tPL7NL9OERtSWof9C/I7UyXbCmLdOILHJqpIVtKvzHIm6KQowB/u0xq
         JKRWJ9VBTW9yD8fy7D5xZqwcu2NXYHqxo2bXghmexvU9g0c+A7tuuvNW2qrBTKwXmbNv
         e7NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZQjOz+ZZ81Ebb5EPtK1mTpOLbzJJlm8KGTxpSWS8pc8=;
        b=unCkYRlBtiSukX/gQjMi1WAxx6wY70+fnKEDTJO9kgnjBtYsDqHBf602URoH6hNcHJ
         eNxoPJ2P/l52P/2kL2N7BFiRIuvfcGLvnl3OX+6VhHUbJYVLJ641Y5Nzbs40ojy6gW1j
         9uy6oA8RED/1U0TWHcNglIQ0KmxK7MSyk9n0kjn75FUrw0Bssm/tiBIaCaFe3ub8TMvT
         gKfGgcZVy1CD3vIgbki2KcPdCNaH/kEyP4XfrluJy1d5nnmqJGcN70q5dLdI0cu6SmrI
         ltmPgPP4zyaZrQYt3SNWPpYVBcJFnaCyWG89wTTRYFFJCw3QfBM9dHQEeT5JVSJ9yhN7
         MXqQ==
X-Gm-Message-State: AOAM53123dHYs7ipKDQ+8K6AI6pbRkWQq6Y/wWebILf4mC111E6yMkdw
        po/hJbHiBOwDXROtrMJkESI=
X-Google-Smtp-Source: ABdhPJyjBIUxZRK0NkYDdB1lV4Hw505+IjfjicfTiMb+15in7gxGkW5eFQAlERYZnJO4M0w1cr159Q==
X-Received: by 2002:a17:906:144e:: with SMTP id q14mr18627455ejc.19.1631625848845;
        Tue, 14 Sep 2021 06:24:08 -0700 (PDT)
Received: from localhost.localdomain (host-79-43-5-131.retail.telecomitalia.it. [79.43.5.131])
        by smtp.gmail.com with ESMTPSA id gc19sm2152431ejb.35.2021.09.14.06.24.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Sep 2021 06:24:08 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>
Subject: Re: [PATCH v4 15/18] staging: r8188eu: hal: Clean up usbctrl_vendorreq()
Date:   Tue, 14 Sep 2021 15:24:06 +0200
Message-ID: <1670478.viNvIS23Oo@localhost.localdomain>
In-Reply-To: <20210914092405.GB2088@kadam>
References: <20210913181002.16651-1-fmdefrancesco@gmail.com> <20210913181002.16651-16-fmdefrancesco@gmail.com> <20210914092405.GB2088@kadam>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, September 14, 2021 11:24:05 AM CEST Dan Carpenter wrote:
> I don't understand why you moved these from the top to the bottom.
> But the original was better.  In networking code declarations are
> normally written in Reverse Christmas Tree format, longest to shortest,
> like this:
> 
> 	long long long_name;
> 	medium name;
> 	u8 short;

Dear Dan,

I'm sorry that I forgot to thank you for the reviews in the other messages I 
sent in reply. :(

I also forgot to answer to the above question...

I changed the order of the declarations because David Laight wrote "I think 
you'll need 'reverse xmas tree' ordering as well." (copy-paste from his 
message).

As far as I know you are both experienced kernel developers, so I took his 
words for truth. Is it a matter of personal taste or Reverse/Non Reverse Xmas 
Trees are strictly required by the Linux kernel coding style guidelines?

I thank you very much for the time you spent for reviewing.

Regards,

Fabio 


