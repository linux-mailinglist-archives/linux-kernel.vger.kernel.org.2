Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C98D833A795
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Mar 2021 20:02:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbhCNTCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Mar 2021 15:02:13 -0400
Received: from m42-2.mailgun.net ([69.72.42.2]:62531 "EHLO m42-2.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233791AbhCNTB7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Mar 2021 15:01:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1615748518; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=HR9jJoTf4lyMl8C4ltT6ssDNUpxMI3Jda3CMTcfVWl4=;
 b=DyEwkROOscHR+3CI2sshUrALk63WicW2XMM3+pnRW+PbjlwVqAFntQ3zM1NtF00SkM/73TJt
 16llMrMN0Bkok5fhupdKmwgnCq9ITdWe2fgF5t1TlJDyydjMmtdiHSl0ts/1BGr/vCNFo69w
 +nNj/D6EKoaucpqDmeftICT1Cu0=
X-Mailgun-Sending-Ip: 69.72.42.2
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 604e5da621031618f6730ba6 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sun, 14 Mar 2021 19:01:58
 GMT
Sender: saiprakash.ranjan=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2CCEAC433CA; Sun, 14 Mar 2021 19:01:58 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2E99CC433CA;
        Sun, 14 Mar 2021 19:01:57 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Mon, 15 Mar 2021 00:31:57 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     akhilpo@codeaurora.org, iommu@lists.linux-foundation.org,
        jcrouse@codeaurora.org, linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        robdclark@gmail.com, robin.murphy@arm.com, will@kernel.org
Subject: Re: [PATCHv2 2/2] iommu/arm-smmu-qcom: Move the adreno smmu specific
 impl earlier
In-Reply-To: <YEqn1SjsGgK0V8K4@builder.lan>
References: <YDlIrjkfv16o4Nu3@builder.lan>
 <20210227135321.420-1-saiprakash.ranjan@codeaurora.org>
 <YEqn1SjsGgK0V8K4@builder.lan>
Message-ID: <8cfaed1915ad6dd0c34ac7eb2391b410@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-03-12 04:59, Bjorn Andersson wrote:
> On Sat 27 Feb 07:53 CST 2021, Sai Prakash Ranjan wrote:
> 
>> Hi Bjorn,
>> 
>> On 2021-02-27 00:44, Bjorn Andersson wrote:
>> > On Fri 26 Feb 12:23 CST 2021, Rob Clark wrote:
>> >
>> >
>> > The current logic picks one of:
>> > 1) is the compatible mentioned in qcom_smmu_impl_of_match[]
>> > 2) is the compatible an adreno
>> > 3) no quirks needed
>> >
>> > The change flips the order of these, so the only way I can see this
>> > change affecting things is if we expected a match on #2, but we got one
>> > on #1.
>> >
>> > Which implies that the instance that we want to act according to the
>> > adreno impl was listed in qcom_smmu_impl_of_match[] - which either is
>> > wrong, or there's a single instance that needs both behaviors.
>> >
>> > (And I believe Jordan's answer confirms the latter - there's a single
>> > SMMU instance that needs all them quirks at once)
>> >
>> 
>> Let me go through the problem statement in case my commit message 
>> wasn't
>> clear. There are two SMMUs (APSS and GPU) on SC7280 and both are 
>> SMMU500
>> (ARM SMMU IP).
>> 
>> APSS SMMU compatible - ("qcom,sc7280-smmu-500", "arm,mmu-500")
>> GPU SMMU compatible - ("qcom,sc7280-smmu-500", "qcom,adreno-smmu", 
>> "arm,mmu-500")
>> 
>> Now if we take SC7180 as an example, GPU SMMU was QSMMU(QCOM SMMU IP)
>> and APSS SMMU was SMMU500(ARM SMMU IP).
>> 
>> APSS SMMU compatible - ("qcom,sc7180-smmu-500", "arm,mmu-500")
>> GPU SMMU compatible - ("qcom,sc7180-smmu-v2", "qcom,adreno-smmu", 
>> "qcom,smmu-v2")
>> 
>> Current code sequence without this patch,
>> 
>> if (of_match_node(qcom_smmu_impl_of_match, np))
>>                  return qcom_smmu_create(smmu, &qcom_smmu_impl);
>> 
>> if (of_device_is_compatible(np, "qcom,adreno-smmu"))
>>         return qcom_smmu_create(smmu, &qcom_adreno_smmu_impl);
>> 
>> Now if we look at the compatible for SC7180, there is no problem 
>> because
>> the APSS SMMU will match the one in qcom_smmu_impl_of_match[] and GPU 
>> SMMU
>> will match "qcom,adreno-smmu" because the compatible strings are 
>> different.
>> But for SC7280, both the APSS SMMU and GPU SMMU 
>> compatible("qcom,sc7280-smmu-500")
>> are same. So GPU SMMU will match with the one in 
>> qcom_smmu_impl_of_match[]
>> i.e.., "qcom,sc7280-smmu-500" which functionally doesn't cause any 
>> problem
>> but we will miss settings for split pagetables which are part of GPU 
>> SMMU
>> specific implementation.
>> 
>> We can avoid this with yet another new compatible for GPU SMMU 
>> something like
>> "qcom,sc7280-adreno-smmu-500" but since we can handle this easily in 
>> the
>> driver and since the IPs are same, meaning if there was a hardware 
>> quirk
>> required, then we would need to apply to both of them and would this 
>> additional
>> compatible be of any help?
>> 
> 
> No, I think you're doing the right thing of having them both. I just
> didn't remember us doing that.
> 
>> Coming to the part of quirks now, you are right saying both SMMUs will 
>> need
>> to have the same quirks in SC7280 and similar others where both are 
>> based on
>> same IPs but those should probably be *hardware quirks* and if they 
>> are
>> software based like the S2CR quirk depending on the firmware, then it 
>> might
>> not be applicable to both. In case if it is applicable, then as Jordan 
>> mentioned,
>> we can add the same quirks in GPU SMMU implementation.
>> 
> 
> I do suspect that at some point (probably sooner than later) we'd have
> to support both inheriting of stream from the bootloader and the Adreno
> "quirks" in the same instance.
> 
> But for now this is okay to me.
> 

Sure, let me know if you or anyone face any issues without it and I will
add it. I will resend this series with the dt-bindings patch for sc7280 
smmu
which wasn't cc'd to smmu folks by mistake.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
