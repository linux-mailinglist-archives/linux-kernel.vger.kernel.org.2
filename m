Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6ED69312DFE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Feb 2021 10:55:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232194AbhBHJyK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Feb 2021 04:54:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231788AbhBHJou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Feb 2021 04:44:50 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6381BC0617AA
        for <linux-kernel@vger.kernel.org>; Mon,  8 Feb 2021 01:43:08 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id f16so11950753wmq.5
        for <linux-kernel@vger.kernel.org>; Mon, 08 Feb 2021 01:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TFMxrL29RVpgXVjucIEhmDqKlJat5xJib/NlFFiNuQo=;
        b=UndgtQlDPAeKtPWb9bsNDWMRGnQrd1pAW/mMraMFTf4urQE7+5N9WeQo0fCwYR7i+d
         tZoR66RNIWLhQ8lyaIfVNcW5CTfOB8VboOH+CoFJS1/JnklSk/utEp1OsgF0z0KDhPig
         FLkVbUxS17sCoEt50/a+kIU7I1REze3wx3ug9MvtomhpwzwHyT3o3H6bupS5SuSzD3fP
         ZrkTyhC45v+8JvtMF19cuUeeAZhb7hBB72QIDQif9e1oZUyNWbwEG/sBDH455fNM1QL9
         YP4JEHulIe/9yx1w2K9kx1nYSShn792RSPZ/czA6TaOHjEO6k4VfaEXfhressHp8Qw5C
         TaPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TFMxrL29RVpgXVjucIEhmDqKlJat5xJib/NlFFiNuQo=;
        b=tzg8yGQvR6vKhEvLmMcic1qJBDUzmPJb8oWpC/yqp3ivtOCPee8ppeHz06KzhL/R+1
         QDyT24+mghzc5cecX/J/YX9cgZ4BhkTL6E/a3aUM2S7+LNu5tG51DYfSY1QrIbHTpZLd
         WB7nM4Ws+sTA+gL0bGYhd/5Asb11pPMBK6w7a2Qc/pVq+UJh8OWpqZsoaSlYXaJKt0SL
         F8HklMCu+mNQFL2f9fWyOvLciwX2+P4/PIaXUCRMEV3rsT8kS3SfyHD1yfE3gL54QBnC
         To+fr3tDKU0H1Ba5AfFQRwambAsGCrvTuvUJFBZkpf2Fu5TKsV+3sG3ZHL0vOrNQCsnM
         iWlA==
X-Gm-Message-State: AOAM530HJwxgSicsAW5Lr/Hh+n/JMJf2OndOuFKJ7CIaiDxx/ntOvH34
        2VV+Goj3vV8UneSrACgc9weG3Q==
X-Google-Smtp-Source: ABdhPJyVam+DreGaG42pavUEMp3dftOST0JCXox76RWH5Agb1flkAmrodIgvcY1S0pzQHz/cRqXJlg==
X-Received: by 2002:a1c:1d8b:: with SMTP id d133mr13984489wmd.172.1612777386189;
        Mon, 08 Feb 2021 01:43:06 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id s64sm21145060wms.21.2021.02.08.01.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Feb 2021 01:43:05 -0800 (PST)
Date:   Mon, 8 Feb 2021 09:43:03 +0000
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Sumit Garg <sumit.garg@linaro.org>
Cc:     kgdb-bugreport@lists.sourceforge.net, jason.wessel@windriver.com,
        dianders@chromium.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] kdb: Simplify kdb commands registration
Message-ID: <20210208094303.csu2kkyi25d7a25y@maple.lan>
References: <1611915427-3196-1-git-send-email-sumit.garg@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1611915427-3196-1-git-send-email-sumit.garg@linaro.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 29, 2021 at 03:47:07PM +0530, Sumit Garg wrote:
> @@ -1011,25 +1005,17 @@ int kdb_parse(const char *cmdstr)
>  		++argv[0];
>  	}
>  
> -	for_each_kdbcmd(tp, i) {
> -		if (tp->cmd_name) {
> -			/*
> -			 * If this command is allowed to be abbreviated,
> -			 * check to see if this is it.
> -			 */
> -
> -			if (tp->cmd_minlen
> -			 && (strlen(argv[0]) <= tp->cmd_minlen)) {
> -				if (strncmp(argv[0],
> -					    tp->cmd_name,
> -					    tp->cmd_minlen) == 0) {
> -					break;
> -				}
> -			}
> -
> -			if (strcmp(argv[0], tp->cmd_name) == 0)
> +	list_for_each_entry(tp, &kdb_cmds_head, list_node) {
> +		/*
> +		 * If this command is allowed to be abbreviated,
> +		 * check to see if this is it.
> +		 */
> +		if (tp->cmd_minlen && (strlen(argv[0]) <= tp->cmd_minlen) &&
> +		    (strncmp(argv[0], tp->cmd_name, tp->cmd_minlen) == 0))
>  				break;

Looks like you forgot to unindent this line.

I will fix it up but... checkpatch would have found this.


Daniel.
