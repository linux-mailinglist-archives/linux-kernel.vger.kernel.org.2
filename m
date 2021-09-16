Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6447940D815
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Sep 2021 13:00:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236506AbhIPLBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Sep 2021 07:01:43 -0400
Received: from de-smtp-delivery-102.mimecast.com ([194.104.109.102]:46935 "EHLO
        de-smtp-delivery-102.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235487AbhIPLBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Sep 2021 07:01:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=mimecast20200619;
        t=1631790019;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=toO5G5v5dDSNR0b2Z2Z69hmuo+1ISuXordVhT4UId7I=;
        b=cxer+HVUoocQyUQiHb+Cud84+wzj/TLeZT4AkoDh4y1OacyDGxT0PmOOM9+BfL5Do2shYY
        oD1ezoj7MjkaYuKLEd83oOBPuXKJ98Q59vIWBQM1Lt6GwaKSm38dQjoXVrtOHwtiLUTAzj
        ZuMnK8qdoHTPFUJ+LWXXOVgjJDDKbDQ=
Received: from EUR04-HE1-obe.outbound.protection.outlook.com
 (mail-he1eur04lp2052.outbound.protection.outlook.com [104.47.13.52]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 de-mta-31-zTioLskgPLiAp1GkopGjBA-1; Thu, 16 Sep 2021 13:00:18 +0200
X-MC-Unique: zTioLskgPLiAp1GkopGjBA-1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=A1r45nf8e8lz6zkT7BUuU0FKT3XP7qNLyAOzAC33Nr1sJ8613Ey/X9HcA4gfWNtTwM03hywU7HifO2kERaQRkJOV0x894AXLE+0TBei3a/qsS42nSoH2082sfJoTTBB7StOuOGCVAIvxn1JXeq1k//MpwVz2rbdYkNkaRazsUcpCV1r0cDHeHhkhi437Lk77rJwXdLZoqhdytpj3VbiehLGg6llQzEVOpT6nug0p48Ppb05wr5jrlXCNoNxj8Xlt/Rt7WKH2jAs0Phe54k6h5gxL0YrFqOyNrkqhjTnuG7ok/u8UmLNSn98U5NUQf8sWrg4hNUQJEigBiwNEEnMEXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901; h=From:Date:Subject:Message-ID:Content-Type:MIME-Version;
 bh=toO5G5v5dDSNR0b2Z2Z69hmuo+1ISuXordVhT4UId7I=;
 b=DZ7c31oSOmOKf8+tdvUUNDyfEJYUGEsjh2ieZqiBoYgtyFx4FEYEn5/Am2mmFECCYOTjYhtBYM751mUxpRDQWbvqKfNMlsEWVjRtXTSIVqw824UUQNeL+olYfLS1tM15Iy811/FRqdvLwuA4Mps2boN1WnjS8IvFyld6g7j0JFFmA6f/xHk78WxfLRdHItyA1tSPf9lnBPm8gSZTK/SRpPfsOBYQZVB23N6K531NP1YJdWFHfXLOMiMW0NvWeZifQekBmm3Q0TZQifh3uES4ADVvftWlv6tHcRsqHd9PwYuIf/7cNbsIsxPerO1TUaB4aN3zERi8yQYUTZ4NMOelJQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
Authentication-Results: redhat.com; dkim=none (message not signed)
 header.d=none;redhat.com; dmarc=none action=none header.from=suse.com;
Received: from AM6PR04MB5366.eurprd04.prod.outlook.com (2603:10a6:20b:9d::19)
 by AM6PR04MB5175.eurprd04.prod.outlook.com (2603:10a6:20b:e::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4500.18; Thu, 16 Sep
 2021 11:00:16 +0000
Received: from AM6PR04MB5366.eurprd04.prod.outlook.com
 ([fe80::e9ae:619b:1fe9:46ce]) by AM6PR04MB5366.eurprd04.prod.outlook.com
 ([fe80::e9ae:619b:1fe9:46ce%6]) with mapi id 15.20.4500.019; Thu, 16 Sep 2021
 11:00:16 +0000
Message-ID: <d05a290c-1715-a3f1-4db3-7e708eae6f91@suse.com>
Date:   Thu, 16 Sep 2021 13:00:14 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.0.3
Subject: Re: [RFC PATCH v2 3/4] drivers/auxdisplay: senshat Raspberry Pi Sense
 HAT display driver
Content-Language: en-US
To:     nsaenzju@redhat.com, Charles Mirabile <cmirabil@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Serge Schneider <serge@raspberrypi.org>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-rpi-kernel@lists.infradead.org, fedora-rpi@googlegroups.com,
        Mwesigwa Guma <mguma@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>
References: <20210820180801.561119-1-cmirabil@redhat.com>
 <20210820180801.561119-4-cmirabil@redhat.com>
 <b7e9dc19babef0e6993fa95be183c598a2f49bbd.camel@redhat.com>
From:   Matthias Brugger <mbrugger@suse.com>
In-Reply-To: <b7e9dc19babef0e6993fa95be183c598a2f49bbd.camel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM4PR0101CA0077.eurprd01.prod.exchangelabs.com
 (2603:10a6:200:41::45) To AM6PR04MB5366.eurprd04.prod.outlook.com
 (2603:10a6:20b:9d::19)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [192.168.2.177] (206.204.146.29) by AM4PR0101CA0077.eurprd01.prod.exchangelabs.com (2603:10a6:200:41::45) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4523.14 via Frontend Transport; Thu, 16 Sep 2021 11:00:15 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cce5d5b9-3ca2-4337-51cd-08d979012a3a
X-MS-TrafficTypeDiagnostic: AM6PR04MB5175:
X-Microsoft-Antispam-PRVS: <AM6PR04MB517533F74BF3E0E413BF7F97BADC9@AM6PR04MB5175.eurprd04.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: M/jjpxtSSUgrbL+81Nl+zOpA8gYM6XY11XooDLRKq9VXeM+LYRd+EYxWH4H021fZ86QWQ5DIgSk/hiBaPbawJ2rWclBE6Jsp5iAou4Iu08Z1ovuvot5wFrd+VyAmt/TIVQ9HjyCVrcXMuScKz0xByeizojNAJnjlGIFi/nCYaLym7wJ45XHFRB89vWUgm8TBQOFD41U7mNLaQAHZn5yxE5eltQoiOIEP5CnbFBWnK6LxZBojzeGDJEnmezmk/D1tAZEtHJeKpmkmwEFKRNIDivzD1CZWiGTNm/cShz89NJNodzB0W7QY4kMPmyES0R1giKDLfMyLdeOMDtOLUiZeRi5DT8qocTTmWhb9RPBMKTGltS7ixeFje7obnnzI8cYN0un9hSyGt0tOWkE3HqOejPLbPxgOhvUpOceGhz3M/Mw0+zXehnADIvay0YDHTkDPgWueBlnBSCHAV+9O0rBwR0z8/0u53XNhnSRwqPdi2E89kTN1ajrkVE4UksATkCLC0xsfUqh4YY0PdEQoYjCTpt8nMUwb+i0GL4Uq7/suM8HXF69YJpTtNMYSgaw+rCql23uj9iABUW7GLIldBifrYbqF2tmjuGEbmI8UBfaZkzzklQcWLAGWth6VFnRcXOCXdInOEhgSKPWtsMFpE+EaT5jWccKWiwSf8DUBOXB6YMFI5t6tlpYaA0yHyaxFRm0aj7ZKYvTPqwsM3HjQ4u5znw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM6PR04MB5366.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(346002)(366004)(39860400002)(396003)(136003)(376002)(53546011)(316002)(66476007)(66946007)(66556008)(8676002)(36756003)(956004)(86362001)(478600001)(2616005)(83380400001)(38100700002)(26005)(31686004)(16576012)(7416002)(31696002)(4326008)(2906002)(5660300002)(186003)(6486002)(8936002)(54906003)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?am1kR2VFTGFGelFhMHFvRHIrRDJqRk1wQjBWOThscFFCUGVlbXdiajlPSGVK?=
 =?utf-8?B?TXJ2dEY3UXBFR1NZaStwYyt5bytYNlRjOGZGWWUycFNFeFozWVJIMHR5MWZj?=
 =?utf-8?B?WDRZZnJqSGF1b3UrY2c2U2hYc21zdUlWMWxlbXIxLzAzZzl0ajZvSGtlUFlC?=
 =?utf-8?B?bS9jb3B6MVBiWmY2dDVYcEFRR0Nla2dTZkYzTXNlUGhoWkZnb2R1dkhsaWJC?=
 =?utf-8?B?NER1WnI0SkY3OHloVWJxVEozeG4vc3Z3cWsvSU9ucG41VHVzNlo3VUlRQ1VW?=
 =?utf-8?B?dVgwN1c0Ti9kTFV1Vzl3a0dwN2ZPQitLK253TWhtWVdyTkxJaGpaSkM1TTNn?=
 =?utf-8?B?MzZlMC9UMUIxWHFodjVocWtJVE9UWkE3OTZxTlFVTXdOMHArbGRRNzFDOFh1?=
 =?utf-8?B?c0NJbEgvdHpKUE5lRjBYYmh1dkFWejlTcmE2cWF4ME9aS3A2bnlTVytLY2VI?=
 =?utf-8?B?eEVpNUxVWG0rYmpKRmJ4UmdiLysyQkNPd3p1Z1BVVTR3ZllXcnJGNnBEQlpK?=
 =?utf-8?B?N1pIWDhxK3ZmajhNWi9WMXc1YXhDcHd2QW93SFcyOEVNRHVpK1V4UzRIN0pC?=
 =?utf-8?B?SkNEU084aFdHLzhuK09MbGJjYmlLWWxBME9zbUNwQlo3TVVTZGF4Sjd6cG5a?=
 =?utf-8?B?Sm9FN1RqRXY0TThtRmtlQVVLd3BXbGgwYnJZTXVmaCtJVzFPS2JoZExpMGVX?=
 =?utf-8?B?enpNaGtwMDJ2V0phdzRNVGc0L0VVWFFER2FsdHhoZDVYb2dkcFZkdXdQK3hF?=
 =?utf-8?B?aklDcUNtdXdJSGRSbDZmL1c1Sis4b0F0YjVMckprWld5MGtoTFB5dDYrWjY3?=
 =?utf-8?B?elUwU1kvVzdsdnhpMzVyQUNSQzRuQXRUTWNqMTNaNnhLVVZwT2xhMWhraGNB?=
 =?utf-8?B?a1YwRWtZRkoydzgrUmdhb3J3MWlpb1ZGbmtEQ2xhVE5MWUFheC9DOXlzY1hM?=
 =?utf-8?B?SjJobTVZNndQNksrb01MUG1wUk56T3hkUDM1KzZtNnVoVEo1YWw4RnVSOTNI?=
 =?utf-8?B?bmxvMmlWbTlzMitYNjhIV2RkdVRMSjdJRGp4QlM3Tjhpa1BYRnpOaS9ZWkpt?=
 =?utf-8?B?bVN5M0tRcjJOdjJmaEVPRVlsZUphQ2tqaDVpZ016dU1jakFWcTYwOFpqYXlE?=
 =?utf-8?B?cFFpZDRtd2FHQ2U2ZUZtRktPVy82ekpxRXJnNjhoa1JCZUQvc1A2dzQwV1Fp?=
 =?utf-8?B?M2NpY1hIWGFRMmZBNUF3WW4weTVFOVFrMnltUDBQUUVGVWZCY2lGTnNNSGNi?=
 =?utf-8?B?dklvd1FvQUdYS0pJTlhRUzJ0Z3QySzJDVjFrc2k2RjRBcGtHWHZOZzlBTWdH?=
 =?utf-8?B?eCt3M0hmNnhzUEg5cFNvSTdDNlJhWE4xT29Nb0pZM2VJY1hvOUE0M0V5SGNm?=
 =?utf-8?B?RGJ5SDBrL0Z0TlBXUE02ZkxJRXhYU3AzTDRPenFLTG9SN3l1QUtTeG9aRHB1?=
 =?utf-8?B?dlRIWGw4OC9lRndSUTRVdDFMTGc4QTIwU1ZVNTBZWmp1QnlGRzZrRFE5NHpM?=
 =?utf-8?B?WS9vc2NRRXRlUFF1ODZVR0w2dFBueitWL3l1bUJUS0FzZU1mQ3dhOVEvYjNT?=
 =?utf-8?B?SU1sdmVuejk2WStHZysrMXFiU29tbzIxYzVlcUxKSHlHVXhYUXdhNnF2NnM4?=
 =?utf-8?B?VmhUY3dmUWxxU01qQXV2RFh3RzRqdlR5ZGtxTXI5WmJSbXExQlU3cUhuR2Yy?=
 =?utf-8?B?bm51c2VsejYxSXdtblgzL3FKdFBHcVd6ajcrWnhEZTAwVjNySXBsbGlxVm1C?=
 =?utf-8?Q?ezPe/IxCJIdM8WTiaxmxTriNoz39Kk1df5A5RE7?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cce5d5b9-3ca2-4337-51cd-08d979012a3a
X-MS-Exchange-CrossTenant-AuthSource: AM6PR04MB5366.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Sep 2021 11:00:16.1648
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /9fWZiOYEzzXzhA2xAwd0jmLTU88O4FpXXdSb9aTGzYzQW1EQ+Jtnl4odmWKf7iKPIINsSvk779COWblQxBNqw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB5175
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2021 15:28, nsaenzju@redhat.com wrote:
> Hi Charles,
> 
> On Fri, 2021-08-20 at 14:08 -0400, Charles Mirabile wrote:
>> This patch implements control of the 8x8 RGB LED matrix display.
> 
> It'd be nice to get a more information on the i2c interface, and what each byte
> is supposed to represent.
> 
>> Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
>> Signed-off-by: Mwesigwa Guma <mguma@redhat.com>
>> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
>> ---
> 
> [...]
> 
>> +static long sensehat_display_ioctl(struct file *filp, unsigned int cmd,
>> +			     unsigned long arg)
>> +{
>> +	struct sensehat *sensehat = container_of(filp->private_data, struct sensehat, display.mdev);
>> +	struct sensehat_display *sensehat_display = &sensehat->display;
>> +	void __user *user_ptr = (void __user *)arg;
>> +	u8 temp[GAMMA_SIZE];
>> +	int ret;
>> +
>> +	if (mutex_lock_interruptible(&sensehat_display->rw_mtx))
>> +		return -ERESTARTSYS;
>> +	switch (cmd) {
>> +	case SENSEDISP_IOGET_GAMMA:
>> +		if (copy_to_user(user_ptr, sensehat_display->gamma, GAMMA_SIZE)) {
>> +			ret = -EFAULT;
>> +			goto out_unlock;
>> +		}
>> +		ret = 0;
>> +		goto out_unlock;
>> +	case SENSEDISP_IOSET_GAMMA:
>> +		if (copy_from_user(temp, user_ptr, GAMMA_SIZE)) {
>> +			ret = -EFAULT;
>> +			goto out_unlock;
>> +		}
>> +		ret = 0;
>> +		goto out_update;
>> +	case SENSEDISP_IORESET_GAMMA:
>> +		if (arg < GAMMA_DEFAULT || arg >= GAMMA_PRESET_COUNT) {
>> +			ret = -EINVAL;
>> +			goto out_unlock;
>> +		}
>> +		memcpy(temp, gamma_presets[arg], GAMMA_SIZE);
>> +		ret = 0;
>> +		goto out_update;
>> +	default:
>> +		ret = -EINVAL;
>> +		goto out_unlock;
>> +	}
>> +out_update:
>> +	memcpy(sensehat_display->gamma, temp, GAMMA_SIZE);
>> +	sensehat_update_display(sensehat);
>> +out_unlock:
>> +	mutex_unlock(&sensehat_display->rw_mtx);
>> +	return ret;
>> +}
>> +
>> +static const struct file_operations sensehat_display_fops = {
>> +	.owner		= THIS_MODULE,
>> +	.llseek		= sensehat_display_llseek,
>> +	.read		= sensehat_display_read,
>> +	.write		= sensehat_display_write,
>> +	.unlocked_ioctl	= sensehat_display_ioctl,
>> +};
> 
> I doubt this approach will make it upstream. This should use an already
> existing kernel interface, or if not good enough, extend it. I'm sure this is
> not the first RGB led matrix to show up anyway. Maybe drivers/leds has
> infrastructure to deal with this. Or else a fb device?

I'm working on upstreaming that again and my approach is to use framebuffer for 
this. What is the reason you decided against framebuffer?

Regards,
Matthias

> 
> I presume you want to keep the IOCTL in order to be able to run RPi specific
> aplications/libraries. It'll be up to them to change once we settle on a proper
> way of handling this, not the other way around. Note that the RPi engineers
> have always preffered using official kernel interfaces when available, so I
> don't think this'll be problematic.
> 
> Regards,
> Nicolas
> 

