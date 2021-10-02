Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA89F41FE4E
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Oct 2021 23:47:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234112AbhJBVtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Oct 2021 17:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234063AbhJBVtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Oct 2021 17:49:16 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA0AC061714
        for <linux-kernel@vger.kernel.org>; Sat,  2 Oct 2021 14:47:30 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id b192-20020a1c1bc9000000b0030cfaf18864so9382556wmb.4
        for <linux-kernel@vger.kernel.org>; Sat, 02 Oct 2021 14:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rammhold-de.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DsMQk+8XXK1QsERSjLKDCEcVwg6XJ78+oxDV4RX+0p8=;
        b=MuS1vyAXNZRsOTxEBMpN7525qbmZsfsMfBl8tK4fsejdN07wZjhlezUBmQAbb9CblL
         wyf8IPNUZwgGUGeRcgf2fJRLTZ2RUP6Fd3KGvnDNlxHMINk9BuXpSIWKOmyOBMHVAOtR
         g7brUyYpEcQToTIV4Rzx/wTQ50y/2N3j/z68bIDfN0S6spafac5Y06tdOUwewj66Kkz2
         3GV9CwRNgNYaLXU5qe/UrsH+jLqrsh/rMpV5a5T9y8GmmH2GnnnW1P3iPEkvIRsTffiU
         xnlEUqr85xK2DQGAs+eSMshhBOkVaGZ8PP0p0Xxsxrnc8PaZsxzMrIhSkB1wujHS/WkU
         VmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DsMQk+8XXK1QsERSjLKDCEcVwg6XJ78+oxDV4RX+0p8=;
        b=6HZovddLP5SUZOXgx3c2yMf2KcWGhUbYU7ywvSm7mUKTyb8Ll5UvA3gBbsMGyPcgn0
         CcStlqbbRglsF5pbbbYyg/7v4eMnQ4Yn1P0hjhYE8BQR1iaj6VYVbPbc4xFa08lu7iYJ
         TC40vLjM19W9QTL8hBbpMVGIsjTlkG44D54bXMs3GWp5aM4CB4k9kpanIIMevenldGkB
         jRAIclXmwxA0XZgLS/yCvZTHSlE/2jBvKbJ1k2reauZ1wqai3Mt5yWnklQHH1jtpjhwY
         nnej+EJ1+C4k/g3sGwuznbDzmI+zel2zjyfVaW95OxTKKDqI0de1LoCQ9rQHuRR9azqj
         ltDQ==
X-Gm-Message-State: AOAM530PWvjlDLgqza0xGz5riaZXui5y4Tq768BbxVaDicWS7/wcQAqN
        Ns0qurmEeHkRTQaPbg5VVTbL4Q==
X-Google-Smtp-Source: ABdhPJwdYX14ToIr9FfRr/UP9/URxjMCG5/550hRz7VmbwRlxzR5s/s0klM9Dzz4ZV2ijUyONK3MYg==
X-Received: by 2002:a7b:c24c:: with SMTP id b12mr985862wmj.173.1633211248812;
        Sat, 02 Oct 2021 14:47:28 -0700 (PDT)
Received: from localhost ([2a00:e67:5c9:a:5621:d377:9a16:5c6c])
        by smtp.gmail.com with ESMTPSA id x9sm9407532wrv.82.2021.10.02.14.47.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Oct 2021 14:47:27 -0700 (PDT)
Date:   Sat, 2 Oct 2021 23:47:25 +0200
From:   Andreas Rammhold <andreas@rammhold.de>
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        James Bottomley <jejb@linux.ibm.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        David Howells <dhowells@redhat.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Sumit Garg <sumit.garg@linaro.org>,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] KEYS: trusted: Fix trusted key backends when building
 as module
Message-ID: <20211002214725.fqmtbfjwtlom745c@wrt>
References: <20210730012822.3460913-1-andreas@rammhold.de>
 <0d42a11a-0117-49a9-d2c9-bc6cc405235d@pengutronix.de>
 <20210927085104.vq42feghtaqiv6ni@wrt>
 <856359f263575f01d0ce2fcf8f042321f750b38c.camel@linux.ibm.com>
 <20210927200835.wvazk73cek3t5tkf@wrt>
 <2ad2c536367028ef6d9300745586a123cb13d9f1.camel@linux.ibm.com>
 <20210927205521.7c4psu4vz5eoyfnf@wrt>
 <81602197662f3e6d032103bd1ac3690342544b7e.camel@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81602197662f3e6d032103bd1ac3690342544b7e.camel@linux.ibm.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17:31 27.09.21, Mimi Zohar wrote:
> On Mon, 2021-09-27 at 22:55 +0200, Andreas Rammhold wrote:
> > On 16:33 27.09.21, Mimi Zohar wrote:
> > > On Mon, 2021-09-27 at 22:08 +0200, Andreas Rammhold wrote:
> > > > On 07:27 27.09.21, Mimi Zohar wrote:
> > > > > On Mon, 2021-09-27 at 10:51 +0200, Andreas Rammhold wrote:
> > > > > > On 09:47 13.09.21, Ahmad Fatoum wrote:
> > > > > > > Dear trusted key maintainers,
> > > > > > > 
> > > > > > > On 30.07.21 03:28, Andreas Rammhold wrote:
> > > > > > > > Before this commit the kernel could end up with no trusted key sources
> > > > > > > > even though both of the currently supported backends (TPM and TEE) were
> > > > > > > > compiled as modules. This manifested in the trusted key type not being
> > > > > > > > registered at all.
> > > > > > > > 
> > > > > > > > When checking if a CONFIG_… preprocessor variable is defined we only
> > > > > > > > test for the builtin (=y) case and not the module (=m) case. By using
> > > > > > > > the IS_REACHABLE() macro we do test for both cases.
> > > > > > > > 
> > > > > > > > Fixes: 5d0682be3189 ("KEYS: trusted: Add generic trusted keys framework")
> > > > > > > > Signed-off-by: Andreas Rammhold <andreas@rammhold.de>
> > > > > > > > Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
> > > > > > > Does anyone intend to pick this up?
> > > > > > 
> > > > > > Did this end up in any tree by now? I am wondering if I should resend
> > > > > > the patch instead. Perhaps it was just overlooked?
> > > > > 
> > > > > For EVM environments only using trusted and encrypted keys, not file
> > > > > signatures, the trusted key is needed to decrypt the "master" key in
> > > > > order to verify kernel modules.
> > > > 
> > > > So what you are saying is that right now (before this patch & after this
> > > > patch) you could compile a kernel that wouldn't be able to load any
> > > > modules when the trusted keychain part is built as module?
> > > 
> > > Before this patch, trusted and encrypted keys are builtin, so verifying
> > > kernel modules with security.evm containing an EVM hmac would succeed. 
> > > Afterwards it would fail, as there's a dependency on the trusted key to
> > > verify the integrity of the trusted key module.
> > 
> > But building with =m was a valid configuration which is the original
> > reason for me submitting the patch. So perhaps this should not be
> > allowed to be a module then?
> 
> My mistake.  Trusted and encrypted key types have always been defined
> as tristate.  Only when EVM selects encrypted keys, and by extension
> trusted keys, are they builtin.

So how do we go about this patch? Building the TPM support as module has
broken actually using the trusted backend. This patch fixes that while
still allowing it to be a builtin. If there is some configuration there
a module isn't acceptable I am sure that is handled within Kconfig?


Andi
