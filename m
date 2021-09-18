Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D76634106D5
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Sep 2021 15:31:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239169AbhIRNdT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Sep 2021 09:33:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238371AbhIRNdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Sep 2021 09:33:15 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AD37C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 06:31:51 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id e26so9419014wmk.2
        for <linux-kernel@vger.kernel.org>; Sat, 18 Sep 2021 06:31:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=btttk93aUSoAIGuvA0mTkUBQEce9Eyd/W3I2VtkIz5w=;
        b=Xhl6QYeEWdrSrlNtd2m8HCfgmI7HSzhbg3rAvOI+cTykhjCqUaR6TRMvnN0e1F5YEy
         dlUa99GeTEiwnz/CW/SLZ8315ZcwZOZIZDOz16YqYCnjgcI655mBl22FIPqKh/QezEZF
         4IFaeDTsGJwtAvPiVgvbkUIgzr6vgk8K8iukxvl1htLUKeAF1NITk65TkHhTO9KVESdr
         NNYQEMK7pSytNsYL5jVvUHXY3Q9ZdFTT6iBoYGEFIkY7w6cVEWF49cZCJ3l86666pren
         40j76a6aGqeltIOwACZmjWGOSM4vFD4+KjYwAj+zd3ZG24u9WSi5M9ASgtiSCt4q6y4s
         Ga9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=btttk93aUSoAIGuvA0mTkUBQEce9Eyd/W3I2VtkIz5w=;
        b=fEYcUR5aKaAVLiKGaakTTUrpxsALwnmBNd0uQKyibMF/NcbjXfkbHvtCSzPrOIdgpU
         q6WbTh5OIfDZcQVR9Zafi9v0YFvu6ZGRd2yHpksXuAlUObYRFDVsOXmtFXcnomTPO34r
         RuOAWU0wf5M1HE+536AbaBzk0yx9nZ5KjbxwM37vr8CwsbWpkB8xLfRTJpJasXkG19Po
         RW68kueK7z2S49ocuqXfefy+xZn0JjcteZlasmIFAgjLcvKzwtYwFAmh9F0L13P5074z
         qjBhk5li6qfqJjNlJSTtKyxkBZKecDjAlBO9cdQynAA4Nzanbep0aXI1gnrv7rRJhvQL
         AEWg==
X-Gm-Message-State: AOAM530BQiZLdT/wIO92ZFsqVtmCNWksa2IYjLWl3qAQEnCnLmkXbThB
        ncyEHylFOsAKHq5+mJDLTnI=
X-Google-Smtp-Source: ABdhPJzW5QuBHT1//iBN/LEipFfEVSJ3k8S4oCN2WTOnucZO6OPPwus7sCOefy0VdP7e1altBeEMDA==
X-Received: by 2002:a1c:3845:: with SMTP id f66mr15396060wma.63.1631971910196;
        Sat, 18 Sep 2021 06:31:50 -0700 (PDT)
Received: from ?IPV6:2a02:8108:96c0:3b88::cde? ([2a02:8108:96c0:3b88::cde])
        by smtp.gmail.com with ESMTPSA id l124sm13781028wml.8.2021.09.18.06.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Sep 2021 06:31:49 -0700 (PDT)
Message-ID: <7f1c135a-d85d-d271-f315-d665a5fe1472@gmail.com>
Date:   Sat, 18 Sep 2021 15:31:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.1.0
Content-Language: en-US
To:     Larry.Finger@lwfinger.net, Phillip Potter <phil@philpotter.co.uk>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        "open list:STAGING SUBSYSTEM" <linux-staging@lists.linux.dev>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
From:   Michael Straube <straube.linux@gmail.com>
Subject: staging: r8188eu: Can odm_DynamicTxPowerNIC() be removed?
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Larry, Phillip and all.

While removing code that checks for the chip type I stumbled upon this:


void odm_DynamicTxPowerNIC(struct odm_dm_struct *pDM_Odm)
{
	if (!(pDM_Odm->SupportAbility & ODM_BB_DYNAMIC_TXPWR))
		return;

	if (pDM_Odm->SupportICType == ODM_RTL8188E) {
		/*  ??? */
		/*  This part need to be redefined. */
	}
}


(pDM_Odm->SupportICType == ODM_RTL8188E) is always true in this driver.
Currently the function does nothing and the driver seems to work fine.
Because of the comment I'm not sure if the whole function can just be
removed?

Regards,
Michael
