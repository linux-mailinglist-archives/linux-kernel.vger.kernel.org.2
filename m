Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9839B3317BE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Mar 2021 20:51:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbhCHTuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Mar 2021 14:50:44 -0500
Received: from mail-il1-f176.google.com ([209.85.166.176]:38869 "EHLO
        mail-il1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231359AbhCHTug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Mar 2021 14:50:36 -0500
Received: by mail-il1-f176.google.com with SMTP id f10so9959607ilq.5;
        Mon, 08 Mar 2021 11:50:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zUEHi9fxgr7OlK2hUQHkI4CDstdppVXLftwBvD8x+2w=;
        b=epZ+Nj3zZd5Fwy6oshsM+IJeq55bDEYFvUc7ShmBSoiQvUR+8mZ0uCtrF5AXQ9PyXg
         P2sZXcIdf6dOJgMzY8qcYYsgoubOzO/qSvPAEenhKtl7ZUeIlvkNgMxgGqAzPTEzHdIV
         FfTixjeUxdBO5lJ9SJAVdw8JeTghaYU7gH6NTEiOpYv0vvLPUPqDM3HWqmNSTIW2xS/M
         YPGCf3UU7XtGUqrXPji6SD0COkJ5zVXJnO1U5zMLTCUtZ/iR8hdarJO+31IDcSIWJKZR
         UtVPwiGa6YnMCHsdIUMJyY09nPbkzPVTni+K7LPTQaH0thidMHXydHfr7e5YfUO7l0X1
         +oiw==
X-Gm-Message-State: AOAM5305w6JD3aWnrfzc6Pr9vlwEC5rKhCWGFxjY0ZlrzTXUWXC++xwI
        zc3cTEGvkPZjUhxW7wHO2w==
X-Google-Smtp-Source: ABdhPJyDCK/yigH+8lLp5Ixku9+13pgiKN+28WfUEXFwFFlcs9knPSnGHB9LxdR4qJJsuVFIWVuJQA==
X-Received: by 2002:a92:60a:: with SMTP id x10mr21704294ilg.262.1615233035599;
        Mon, 08 Mar 2021 11:50:35 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.253])
        by smtp.gmail.com with ESMTPSA id q6sm6771545ilm.66.2021.03.08.11.50.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Mar 2021 11:50:34 -0800 (PST)
Received: (nullmailer pid 2855345 invoked by uid 1000);
        Mon, 08 Mar 2021 19:50:33 -0000
Date:   Mon, 8 Mar 2021 12:50:33 -0700
From:   Rob Herring <robh@kernel.org>
To:     dillon.minfei@gmail.com
Cc:     alexandre.torgue@st.com, linux-arm-kernel@lists.infradead.org,
        robh+dt@kernel.org, mcoquelin.stm32@gmail.com,
        devicetree@vger.kernel.org, linux@armlinux.org.uk,
        linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com, afzal.mohd.ma@gmail.com,
        vladimir.murzin@arm.com
Subject: Re: [PATCH 4/8] dt-bindings: pinctrl: stm32: Add stm32h750 pinctrl
Message-ID: <20210308195033.GA2855292@robh.at.kernel.org>
References: <1614758717-18223-1-git-send-email-dillon.minfei@gmail.com>
 <1614758717-18223-5-git-send-email-dillon.minfei@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1614758717-18223-5-git-send-email-dillon.minfei@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 03 Mar 2021 16:05:13 +0800, dillon.minfei@gmail.com wrote:
> From: dillon min <dillon.minfei@gmail.com>
> 
> Signed-off-by: dillon min <dillon.minfei@gmail.com>
> ---
>  Documentation/devicetree/bindings/pinctrl/st,stm32-pinctrl.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>
