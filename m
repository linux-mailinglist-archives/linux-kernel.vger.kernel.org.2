Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE8141911B
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Sep 2021 10:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233528AbhI0IxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Sep 2021 04:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233495AbhI0IxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Sep 2021 04:53:03 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B1F3C061714
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 01:51:23 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id y35so15006040ede.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Sep 2021 01:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rammhold-de.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=vpiI5pj2Ftv2EK8BLb2NkBV+XKtwEHr6p/9jAqbGbAE=;
        b=BhkSvc+zNkulAdU66B6+X3PLa6HTc7zTdIZ7CKNvaupwXco2ce3J1ojxFID/7Avvkh
         vKV7Lz9TZZzOIcWGJuAukVWFdUKSHRmCT3np3zdY1ZBbv0sVjr96CwPggmpFw7VmdXON
         sklUqge3izjUabowL5z/oxI0ot81qap1t4eJaodiGkQoSjjEv3IJjpNDuSqMM6wx2FJj
         E1gBvz+oQ2DE86AidE5KJcGWKHarVm4zQUhDS2y0WpBY0ly2VN/7d6fYscJ/HiwFV9xl
         eZ0fpHR6SvqVFFTjkFuf0J3o0ardaYbzmKiBhX0OWTYjcOzeHlqylWK4ScUTazBiL+m7
         eAHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=vpiI5pj2Ftv2EK8BLb2NkBV+XKtwEHr6p/9jAqbGbAE=;
        b=Sdf1cTh4eu2kOV2T+SB+Mo/J+YLhjDdn2X2zmfu7MlGVpkA5jnMCl4pzhnsNmYurzi
         oPSmjtoF5PtN9++mr9hCSQ5ckXN+jwDgnx/7XD+yLz6WpGc66+af3oG9Sdqg0UxTYjLV
         /z3IL0XvIxK7EUBsClL2+DibEDec65Jj9ubwMJMHB9apsEZvzHvAgNxJ9w0ftcbTAOLF
         tSW9aIcwWV8eIQmE9UzetP9uHw6IQWNWP0wbHMPUZf9Zs9P67d9NbfXlKKHHlQR1G47K
         uK9MxX9ot1FpwqZDuKZTCp5/2hcodFlDlUVIvjF/Fs30SxhExXVuVlMUyOe2d4E2VU1F
         SBQQ==
X-Gm-Message-State: AOAM5326GWrp6tDwiaLj69eHyUWN40EbjExnX8D1KzMIxvY+qyq14R5z
        2LImoX1nHPhVw3kVyvj2l0gZNA==
X-Google-Smtp-Source: ABdhPJyGrcZoq7BRymoATY3WZexa99+brf/ZH5Kkqlnjq0KM2/GBXtUm597ruB9k9urrT5xeVjJXVA==
X-Received: by 2002:a17:906:2505:: with SMTP id i5mr25674695ejb.450.1632732681907;
        Mon, 27 Sep 2021 01:51:21 -0700 (PDT)
Received: from localhost ([2a00:e67:5c9:a:6d7b:fc0:e9e9:7254])
        by smtp.gmail.com with ESMTPSA id m22sm10262359edq.71.2021.09.27.01.51.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Sep 2021 01:51:20 -0700 (PDT)
Date:   Mon, 27 Sep 2021 10:51:04 +0200
From:   Andreas Rammhold <andreas@rammhold.de>
To:     Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc:     Andreas Rammhold <andreas@rammhold.de>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Mimi Zohar <zohar@linux.ibm.com>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] KEYS: trusted: Fix trusted key backends when building
 as module
Message-ID: <20210927085104.vq42feghtaqiv6ni@wrt>
References: <20210730012822.3460913-1-andreas@rammhold.de>
 <0d42a11a-0117-49a9-d2c9-bc6cc405235d@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0d42a11a-0117-49a9-d2c9-bc6cc405235d@pengutronix.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09:47 13.09.21, Ahmad Fatoum wrote:
> Dear trusted key maintainers,
> 
> On 30.07.21 03:28, Andreas Rammhold wrote:
> > Before this commit the kernel could end up with no trusted key sources
> > even though both of the currently supported backends (TPM and TEE) were
> > compiled as modules. This manifested in the trusted key type not being
> > registered at all.
> > 
> > When checking if a CONFIG_… preprocessor variable is defined we only
> > test for the builtin (=y) case and not the module (=m) case. By using
> > the IS_REACHABLE() macro we do test for both cases.
> > 
> > Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
> > Signed-off-by: Andreas Rammhold <andreas@rammhold.de>
> > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> Does anyone intend to pick this up?

Did this end up in any tree by now? I am wondering if I should resend
the patch instead. Perhaps it was just overlooked?


Andi
