Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F3B9A32CCB2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Mar 2021 07:19:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234980AbhCDGSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Mar 2021 01:18:09 -0500
Received: from mail-eopbgr30072.outbound.protection.outlook.com ([40.107.3.72]:8095
        "EHLO EUR03-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234859AbhCDGRq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Mar 2021 01:17:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7q62OBTF4EkX1ZsI2jfOxA25JLYPsVgD44kkdhdghg=;
 b=Yj7BDjvZfF4dglygE3UHaCa1GPQZq8WuLsv8CYO6/8AswgiEhSbfj7CvGMbOAKr+hODe/ZxzwchlLL94wrD02yyxk0SaclzM2vujYbNYuxlCY/2eoL19rThs/ZM10X8IUbMOKlqk9TkeAbrXjsxaaBKwnDelVgwVfVFVI0Jn4cE=
Received: from AM6P193CA0057.EURP193.PROD.OUTLOOK.COM (2603:10a6:209:8e::34)
 by AM4PR08MB2850.eurprd08.prod.outlook.com (2603:10a6:205:3::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17; Thu, 4 Mar
 2021 06:16:58 +0000
Received: from AM5EUR03FT043.eop-EUR03.prod.protection.outlook.com
 (2603:10a6:209:8e:cafe::15) by AM6P193CA0057.outlook.office365.com
 (2603:10a6:209:8e::34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.17 via Frontend
 Transport; Thu, 4 Mar 2021 06:16:58 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 63.35.35.123)
 smtp.mailfrom=arm.com; vger.kernel.org; dkim=pass (signature was verified)
 header.d=armh.onmicrosoft.com;vger.kernel.org; dmarc=pass action=none
 header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 63.35.35.123 as permitted sender) receiver=protection.outlook.com;
 client-ip=63.35.35.123; helo=64aa7808-outbound-1.mta.getcheckrecipient.com;
Received: from 64aa7808-outbound-1.mta.getcheckrecipient.com (63.35.35.123) by
 AM5EUR03FT043.mail.protection.outlook.com (10.152.17.43) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3912.17 via Frontend Transport; Thu, 4 Mar 2021 06:16:57 +0000
Received: ("Tessian outbound 7213b86582b6:v71"); Thu, 04 Mar 2021 06:16:57 +0000
X-CheckRecipientChecked: true
X-CR-MTA-CID: 68feea4b631c5a43
X-CR-MTA-TID: 64aa7808
Received: from 24b8a9296dbc.3
        by 64aa7808-outbound-1.mta.getcheckrecipient.com id 773A94CC-1683-4430-BD49-05660D601E23.1;
        Thu, 04 Mar 2021 06:16:51 +0000
Received: from EUR04-VI1-obe.outbound.protection.outlook.com
    by 64aa7808-outbound-1.mta.getcheckrecipient.com with ESMTPS id 24b8a9296dbc.3
    (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384);
    Thu, 04 Mar 2021 06:16:51 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dMVtiFreEDCedHnvsXb2e+4pDKG7j2+0/JR4pmvDWYAjKTbvcwjIBDKeDMkWseQ9r6xr+KlavDYR+bX5sXMRJvptXqPWNwyEYM0MMFTKY9rtx5a+FA/mx6ZL2p3/wsvh6oG3+0BsZ/iSD91yRe74fdFqr7WZ/F1YnKcm3z5brhlWivSpTIrRT/LaJEAyAwvvw3ENC8NqWENTMhEBL2PlNnwyTRb2/T+6f/zsBmP9PUxhkLq2LCKmQhX4F8jfuD1ndyhDTojud1+w6qAOVzJ9SLR3GsKjgijuyJv+ABp5CJXGEJkMC7jXlW4mldcfOZSNColw6aTpFrbjPJzoty6mzA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7q62OBTF4EkX1ZsI2jfOxA25JLYPsVgD44kkdhdghg=;
 b=J/jEbgGqYdAx1i6u+PMs6nru9Dl3T8uIBnLP93Rkfo+I1T1TQFyxwXsa3u0ZCPcvOJLpdI73qBlhqmEnYAgdI0LlVxjRIgutRpQsNUeRPsDvFi5gdh4Nh8hbYw8mizU/ZbNAr7ZlJ5FgZ6MqjrTdmKxpFNO2VOvsLh1He2/LFMwwyuLkCIcU0E8ey/iRmJKbvD7CHqbLgHIVJc289IDlJcH/QAQATf3pg5X4GlyAy68dKNroAVy4cMvhWcDUfY6dfK5CPJe+9zRRGO3Nutan8NFlBkcSor00q72RAqAtpvqRKQ6/m871yzb7VLMPII3s2IF7oEMfmr8v7xy7UJnrWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=armh.onmicrosoft.com;
 s=selector2-armh-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=c7q62OBTF4EkX1ZsI2jfOxA25JLYPsVgD44kkdhdghg=;
 b=Yj7BDjvZfF4dglygE3UHaCa1GPQZq8WuLsv8CYO6/8AswgiEhSbfj7CvGMbOAKr+hODe/ZxzwchlLL94wrD02yyxk0SaclzM2vujYbNYuxlCY/2eoL19rThs/ZM10X8IUbMOKlqk9TkeAbrXjsxaaBKwnDelVgwVfVFVI0Jn4cE=
Authentication-Results-Original: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
Received: from AM0PR08MB3268.eurprd08.prod.outlook.com (2603:10a6:208:65::26)
 by AM0PR08MB4498.eurprd08.prod.outlook.com (2603:10a6:208:13c::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.19; Thu, 4 Mar
 2021 06:16:49 +0000
Received: from AM0PR08MB3268.eurprd08.prod.outlook.com
 ([fe80::b55a:5a00:982b:a685]) by AM0PR08MB3268.eurprd08.prod.outlook.com
 ([fe80::b55a:5a00:982b:a685%6]) with mapi id 15.20.3912.017; Thu, 4 Mar 2021
 06:16:48 +0000
Subject: Re: [PATCH RFC v1 12/15] iommu/virtio: Add support for INVALIDATE
 request
To:     "Tian, Kevin" <kevin.tian@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        "mst@redhat.com" <mst@redhat.com>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "jean-philippe@linaro.org" <jean-philippe@linaro.org>,
        "eric.auger@redhat.com" <eric.auger@redhat.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "shameerali.kolothum.thodi@huawei.com" 
        <shameerali.kolothum.thodi@huawei.com>
References: <20210115121342.15093-1-vivek.gautam@arm.com>
 <20210115121342.15093-13-vivek.gautam@arm.com>
 <20210303102848.5d879f0e@jacob-builder>
 <MWHPR11MB1886860008D526446026E7E58C979@MWHPR11MB1886.namprd11.prod.outlook.com>
From:   Vivek Kumar Gautam <vivek.gautam@arm.com>
Message-ID: <92b6384b-29ff-ed15-ce65-02c18eefc5b8@arm.com>
Date:   Thu, 4 Mar 2021 11:46:40 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
In-Reply-To: <MWHPR11MB1886860008D526446026E7E58C979@MWHPR11MB1886.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [217.140.105.56]
X-ClientProxiedBy: PN2PR01CA0126.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c01:6::11) To AM0PR08MB3268.eurprd08.prod.outlook.com
 (2603:10a6:208:65::26)
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
Received: from [10.162.16.71] (217.140.105.56) by PN2PR01CA0126.INDPRD01.PROD.OUTLOOK.COM (2603:1096:c01:6::11) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3912.18 via Frontend Transport; Thu, 4 Mar 2021 06:16:45 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-HT: Tenant
X-MS-Office365-Filtering-Correlation-Id: 62b9c973-53c8-4676-06f6-08d8ded51d8c
X-MS-TrafficTypeDiagnostic: AM0PR08MB4498:|AM4PR08MB2850:
X-MS-Exchange-Transport-Forked: True
X-Microsoft-Antispam-PRVS: <AM4PR08MB285048D7D4683ED571FEB09589979@AM4PR08MB2850.eurprd08.prod.outlook.com>
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-Microsoft-Antispam-Untrusted: BCL:0;
X-Microsoft-Antispam-Message-Info-Original: KE/g/dCIfVA1VU8pyPPRThVCSuzCQs4OAcNoKEkIIdRvwuClOgwIy8brzdJxVxamfhjWNNb+W2OpFECBlwek+ciopvJoB9TUL2Pt+gsCVTn1ZZf90ALMf46FE94qFKyD6mhfXY1YSZTs9WNeLvQFK3z7wEo2sWVrnuzmrgN1VxkwOZd/zOEUAVYRE8Pkc2qCfuHX+OCVSh4UM4WrzDBgeE7mO6MLr8HZ6xiRp9BHm1BtIwjA+VTszr642DRZAllxFXhLvpbDJmayjRM9Z8h9fVC6C/SHQLjusC28T6A6rFIOLO0RZQSy+v6kgRSX2aOoWdYKsVceKEVZFf7Io7Fl5eza1/7mrskZUZ4OHCtyCWu6yt3TU1Og8tVt/xfL2aQVdZyx3RgVUGUnNvC5j1PZNV+xdWYfNzwNdz0L+RQAb4M/mRsiFlBafiTAlH6b8yA9xBLGJqfy39git3j+xSZz4pg9G1EJWTOxwhw5toEpZaSNFKGSyMjlF7dKvuhkWj5VN2xpX/Xt/QUEi+dxUoXKkBaoRwZkYlOtyevUqANiUpKnOdhztbH8dcbB50xLYKWMLD1PgL9C0MMd5DJm2QV/fKKLaEO/6tFrs0O8qhwLq9A=
X-Forefront-Antispam-Report-Untrusted: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM0PR08MB3268.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(396003)(136003)(376002)(346002)(366004)(39850400004)(66946007)(66476007)(66556008)(54906003)(6486002)(16576012)(83380400001)(110136005)(8676002)(8936002)(316002)(36756003)(2906002)(52116002)(4326008)(31696002)(86362001)(478600001)(53546011)(5660300002)(186003)(6666004)(31686004)(16526019)(26005)(7416002)(2616005)(956004)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData: =?utf-8?B?UmJwMXc3ODU5NEpJYW1uNlNETHhWc2Q0TWRFaTRlb2RWeGRtRkYycy9BUDJ3?=
 =?utf-8?B?a0ZUYXBybTZXdFNGL2xUSWFRaG5KVlY3d0ZPTWpoVGdWRnBiVW52LzEvdHFY?=
 =?utf-8?B?QkQ3VXBUMXE3M0U0eWgrMklnZkIzUlhIN3NYWmlCUXQzNVJHZVlwcG0rT2J6?=
 =?utf-8?B?Rmh4Y0dnVEZJeUpqQ1ZSVC81YnhZRTh2aklWOTFuS3hMdHZaYVRpcTM5UmZQ?=
 =?utf-8?B?VW5JTVVGSEZpRWRnclRJNksrOXdZY0JVS2w1ZmovSkZ5a296TEJrT0JrNWlw?=
 =?utf-8?B?cExSNlpZdGUySnRpY0VVbGR3Sit6WDFsMVIvQzgwa2dyRTVDUmNNR29JWk9S?=
 =?utf-8?B?ZitHbDg3TmpNTmRqTXIwWWtxVUd2UEZzZFd4WFFzOHhlNC9MMlljelVCWDEr?=
 =?utf-8?B?aFA1K3hkMTltamE4Q1NUaW1BYW9sVG9XWXRoUHJLcE1xaktvM0hzQXlvUmVU?=
 =?utf-8?B?aHNFbWJ3c21HWGxndzJpclMzalhHMnNmeGxaMDNCbGxJWWdFU3NGdDFHeDB1?=
 =?utf-8?B?cHpHTk5FbkpJT0ZyZjRSdStlSjd2QkFpb2d2WGgwTkl0bzBnKys4YlZqaVU1?=
 =?utf-8?B?NkwvYURyRUFTam1uU3h5TDZtZEczUk83NCtDaVM0am84OGNBMk1mQTl3NFVN?=
 =?utf-8?B?bElnak4vbHBlb0lQTXJDSitsRDh3ci9xTHVCeTR4aWRIYW5EVWo5bzU0R3Vx?=
 =?utf-8?B?bVJZeExLKy9EdjZqakk2bTVFc0dXUUg2TEFRV044R1VhcTBpM2pRNzZiS0VF?=
 =?utf-8?B?N2xNT3RsZjF3a05CQlNaSExoa1JRU0N2SDcyaFZXN1J6YUtDRWpWQzZPdG9x?=
 =?utf-8?B?WGRjY016MjA4aFcvbHVwcjh2OXJrYXd5MGJ1WkdCQnVEckQwLzRyOUFIdFRu?=
 =?utf-8?B?MStXTkNBMkZ0WTFSdDltR2g1VmtQMzVNV2d6Vk95dk1obTluaWgzMmRzZWRa?=
 =?utf-8?B?WHo5eWVsd1NkWVp5WUM5M3lCZEZpZTgraFpZQ1JQcUlJdzZVRWpDaFVpbmd6?=
 =?utf-8?B?RDN1S2hiRmNJQ1NJWjg4dGdkYmNWSFVPMk5CcHBlQjhoNElSQVVrT25GbGZD?=
 =?utf-8?B?MDk1TWZieXRTWXJ3T3g4NWIzMVdETDRiaTdHZFVnWUZ3MEN3OHNkZkVBd2tk?=
 =?utf-8?B?bzRrc1FsY0ptcHJpeTlPRThpbkhpbjBuZDNlN2F5Z3V6NVFNTUtMSTFxZUNQ?=
 =?utf-8?B?eGx3dnVzUURlcjRqd0ZTSjJzaEw2SVFnYTZyeXBmUmVtakI1SVV5NHlrc2xt?=
 =?utf-8?B?bXBtbTFvWHdvcXhUWjJNTFBPRFA3ZVk4cDJyc3l6UWVLVzF4Qm54WlZTa2hQ?=
 =?utf-8?B?bWpuU21FWU5icUtuOUhYdElXV25makFiOUZvNUF3UVcvYnJIK2U1TmMyOWVQ?=
 =?utf-8?B?S09ubHBpOHJBakxVM0tiK0ttbFhMRklzWlVUWDljY2htb3lCZmoxL1U3dkQw?=
 =?utf-8?B?a2c4cGdsZkM2bmJEQ0Rwbk9TdWpjMzRZTXA0K3pVMnpKSDZnU042OVFtdWd5?=
 =?utf-8?B?YXBPZDFUWVFhNHl5WDA1VFlYR1UxSFVqdDBadlo1bnVQY2V0Uy9vY2xITnhm?=
 =?utf-8?B?bmdMaytSM0VtS0tZS0VyejIvUTRMZnNTUnVGRU9aZk83ek1uS0poeEZ2RXo2?=
 =?utf-8?B?SHh6SEdDeXV0RWpVRUJVT09BalRZT3FnQ0hqUklXSTQyTnU1NmNISDQ5bXdr?=
 =?utf-8?B?OVNZTWRodHpkb3lXTnBvNWhIZmtzaHlHNEVxV3F1d0xwSnlkMEVnR3RVdEJI?=
 =?utf-8?Q?6r6M0iPc7gGaZOXfX76+8sdd7FO6sA8Qh/TlNnR?=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR08MB4498
Original-Authentication-Results: huawei.com; dkim=none (message not signed)
 header.d=none;huawei.com; dmarc=none action=none header.from=arm.com;
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped: AM5EUR03FT043.eop-EUR03.prod.protection.outlook.com
X-MS-Office365-Filtering-Correlation-Id-Prvs: 2a0d959e-dc0b-4dc4-4975-08d8ded5179e
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 60LcJZDgosSFTYElTbAcEtwd0OZ+OQlpWBcxBqi+wkaPTvwPlSqpK5yRx/dBdTG1AhyPsM6c1Tke9m+PBl0/GH7mor3bqbAZVC3veqOKUQiNfyDxVU4JHAlNxZrEN8VSzFWfA81k25QrLXfLYS0ig0CwczwbFXQ+ewFPAxvOmoAz7NVatgo77ie2WcA5SeU9MUVZ55aYEzYqNhW8TC6sF/MLa7dE0mZ8gtTghPsOcHVOVi83z1nZ5S3YrMg+PZ2jjMQupyEBqrl/muIbCleCLMOk8WbOBPujuYptkUgcJ59kGX2FJweuh4aT/tEGlNYO6VFFqkLqVkIV9U+4Mi3MN1NKLgSkxRI6NktnQQ6eBECublsA8UsCoXnQN81zi0EnUsJ4jpFn+qSir6dUnddmBGnkr32fggYfT4qmo/E4lBUsnDbwojx8z1pfjpBhKXdVsaWs3LXHnrjjtlTGgu3dL7hQNtFmLPKRsm/A7A0ZMz326/QAVGycgwrxZNKC6wEbhbDkBOX5iIwJ3B+WdkPQKP08ovz1aTYuVhZob0Hfe8WjpyX03x+L6jo4w/s/I8iuGnUqacCoBfJkYuYr/1w8bZgCcZ6poGJwKI4xaqcTsuRyQrdSrmbkvOA4kMgXDcxTkibXRLQHqsi0opC7/4wc3n6cOeRSN45M3xqj42HacFF/3c9llHIl2J0CZyshRvY8
X-Forefront-Antispam-Report: CIP:63.35.35.123;CTRY:IE;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:64aa7808-outbound-1.mta.getcheckrecipient.com;PTR:ec2-63-35-35-123.eu-west-1.compute.amazonaws.com;CAT:NONE;SFS:(4636009)(136003)(396003)(39850400004)(346002)(376002)(46966006)(36840700001)(26005)(8936002)(82310400003)(36860700001)(16576012)(2906002)(6486002)(8676002)(316002)(31696002)(86362001)(54906003)(31686004)(110136005)(107886003)(70206006)(70586007)(47076005)(36756003)(16526019)(478600001)(336012)(83380400001)(82740400003)(956004)(5660300002)(53546011)(186003)(356005)(81166007)(6666004)(4326008)(2616005)(43740500002);DIR:OUT;SFP:1101;
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Mar 2021 06:16:57.7221
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 62b9c973-53c8-4676-06f6-08d8ded51d8c
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[63.35.35.123];Helo=[64aa7808-outbound-1.mta.getcheckrecipient.com]
X-MS-Exchange-CrossTenant-AuthSource: AM5EUR03FT043.eop-EUR03.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM4PR08MB2850
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jacob, Kevin,


On 3/4/21 11:28 AM, Tian, Kevin wrote:
>> From: Jacob Pan <jacob.jun.pan@linux.intel.com>
>> Sent: Thursday, March 4, 2021 2:29 AM
>>
>> Hi Vivek,
>>
>> On Fri, 15 Jan 2021 17:43:39 +0530, Vivek Gautam <vivek.gautam@arm.com>
>> wrote:
>>
>>> From: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>>>
>>> Add support for tlb invalidation ops that can send invalidation
>>> requests to back-end virtio-iommu when stage-1 page tables are
>>> supported.
>>>
>> Just curious if it possible to reuse the iommu uapi for invalidation and others.
>> When we started out designing the iommu uapi, the intention was to support
>> both emulated and virtio iommu.
> 
> IIUC this patch is about the protocol between virtio-iommu frontend and backend.
> After the virtio-iommu backend receives invalidation ops, it then needs to
> forward the request to the host IOMMU driver through the existing iommu
> uapi that you referred to, as a emulated VT-d or SMMU would do.

Thanks a lot for looking at the patch.

Yes this patch is to provide the front-end virtio interface for 
invalidation requests during map/unmap and when flushing the pasid 
tables when virtio-iommu requested pasid table (in other words cd tables 
for arm-smmu-v3) from the iommu-pasid-table library.
The kvmtool back-end virtio driver forwards these requests to vfio 
driver which then makes use of iommu uapi to finally request host iommu 
driver for handling these invalidations.

Regards
Vivek

> 
> Thanks
> Kevin
> 
>>
>>> Signed-off-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
>>> [Vivek: Refactoring the iommu_flush_ops, and adding only one pasid sync
>>>          op that's needed with current iommu-pasid-table infrastructure.
>>> 	Also updating uapi defines as required by latest changes]
>>> Signed-off-by: Vivek Gautam <vivek.gautam@arm.com>
>>> Cc: Joerg Roedel <joro@8bytes.org>
>>> Cc: Will Deacon <will.deacon@arm.com>
>>> Cc: Michael S. Tsirkin <mst@redhat.com>
>>> Cc: Robin Murphy <robin.murphy@arm.com>
>>> Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>
>>> Cc: Eric Auger <eric.auger@redhat.com>
>>> Cc: Alex Williamson <alex.williamson@redhat.com>
>>> Cc: Kevin Tian <kevin.tian@intel.com>
>>> Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
>>> Cc: Liu Yi L <yi.l.liu@intel.com>
>>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>>> Cc: Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>
>>> ---
>>>   drivers/iommu/virtio-iommu.c | 95
>> ++++++++++++++++++++++++++++++++++++
>>>   1 file changed, 95 insertions(+)
>>>
>>> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
>>> index ae5dfd3f8269..004ea94e3731 100644
>>> --- a/drivers/iommu/virtio-iommu.c
>>> +++ b/drivers/iommu/virtio-iommu.c
>>> @@ -13,6 +13,7 @@
>>>   #include <linux/freezer.h>
>>>   #include <linux/interval_tree.h>
>>>   #include <linux/iommu.h>
>>> +#include <linux/io-pgtable.h>
>>>   #include <linux/module.h>
>>>   #include <linux/of_iommu.h>
>>>   #include <linux/of_platform.h>
>>> @@ -63,6 +64,8 @@ struct viommu_mapping {
>>>   };
>>>
>>>   struct viommu_mm {
>>> +	int				pasid;
>>> +	u64				archid;
>>>   	struct io_pgtable_ops		*ops;
>>>   	struct viommu_domain		*domain;
>>>   };
>>> @@ -692,6 +695,98 @@ static void viommu_event_handler(struct
>> virtqueue
>>> *vq) virtqueue_kick(vq);
>>>   }
>>>
>>> +/* PASID and pgtable APIs */
>>> +
>>> +static void __viommu_flush_pasid_tlb_all(struct viommu_domain
>> *vdomain,
>>> +					 int pasid, u64 arch_id, int
>>> type) +{
>>> +	struct virtio_iommu_req_invalidate req = {
>>> +		.head.type	= VIRTIO_IOMMU_T_INVALIDATE,
>>> +		.inv_gran	=
>>> cpu_to_le32(VIRTIO_IOMMU_INVAL_G_PASID),
>>> +		.flags		=
>>> cpu_to_le32(VIRTIO_IOMMU_INVAL_F_PASID),
>>> +		.inv_type	= cpu_to_le32(type),
>>> +
>>> +		.domain		= cpu_to_le32(vdomain->id),
>>> +		.pasid		= cpu_to_le32(pasid),
>>> +		.archid		= cpu_to_le64(arch_id),
>>> +	};
>>> +
>>> +	if (viommu_send_req_sync(vdomain->viommu, &req, sizeof(req)))
>>> +		pr_debug("could not send invalidate request\n");
>>> +}
>>> +
>>> +static void viommu_flush_tlb_add(struct iommu_iotlb_gather *gather,
>>> +				 unsigned long iova, size_t granule,
>>> +				 void *cookie)
>>> +{
>>> +	struct viommu_mm *viommu_mm = cookie;
>>> +	struct viommu_domain *vdomain = viommu_mm->domain;
>>> +	struct iommu_domain *domain = &vdomain->domain;
>>> +
>>> +	iommu_iotlb_gather_add_page(domain, gather, iova, granule);
>>> +}
>>> +
>>> +static void viommu_flush_tlb_walk(unsigned long iova, size_t size,
>>> +				  size_t granule, void *cookie)
>>> +{
>>> +	struct viommu_mm *viommu_mm = cookie;
>>> +	struct viommu_domain *vdomain = viommu_mm->domain;
>>> +	struct virtio_iommu_req_invalidate req = {
>>> +		.head.type	= VIRTIO_IOMMU_T_INVALIDATE,
>>> +		.inv_gran	= cpu_to_le32(VIRTIO_IOMMU_INVAL_G_VA),
>>> +		.inv_type	=
>> cpu_to_le32(VIRTIO_IOMMU_INV_T_IOTLB),
>>> +		.flags		=
>>> cpu_to_le32(VIRTIO_IOMMU_INVAL_F_ARCHID), +
>>> +		.domain		= cpu_to_le32(vdomain->id),
>>> +		.pasid		= cpu_to_le32(viommu_mm->pasid),
>>> +		.archid		= cpu_to_le64(viommu_mm->archid),
>>> +		.virt_start	= cpu_to_le64(iova),
>>> +		.nr_pages	= cpu_to_le64(size / granule),
>>> +		.granule	= ilog2(granule),
>>> +	};
>>> +
>>> +	if (viommu_add_req(vdomain->viommu, &req, sizeof(req)))
>>> +		pr_debug("could not add invalidate request\n");
>>> +}
>>> +
>>> +static void viommu_flush_tlb_all(void *cookie)
>>> +{
>>> +	struct viommu_mm *viommu_mm = cookie;
>>> +
>>> +	if (!viommu_mm->archid)
>>> +		return;
>>> +
>>> +	__viommu_flush_pasid_tlb_all(viommu_mm->domain,
>> viommu_mm->pasid,
>>> +				     viommu_mm->archid,
>>> +				     VIRTIO_IOMMU_INV_T_IOTLB);
>>> +}
>>> +
>>> +static struct iommu_flush_ops viommu_flush_ops = {
>>> +	.tlb_flush_all		= viommu_flush_tlb_all,
>>> +	.tlb_flush_walk		= viommu_flush_tlb_walk,
>>> +	.tlb_add_page		= viommu_flush_tlb_add,
>>> +};
>>> +
>>> +static void viommu_flush_pasid(void *cookie, int pasid, bool leaf)
>>> +{
>>> +	struct viommu_domain *vdomain = cookie;
>>> +	struct virtio_iommu_req_invalidate req = {
>>> +		.head.type	= VIRTIO_IOMMU_T_INVALIDATE,
>>> +		.inv_gran	=
>>> cpu_to_le32(VIRTIO_IOMMU_INVAL_G_PASID),
>>> +		.inv_type	=
>> cpu_to_le32(VIRTIO_IOMMU_INV_T_PASID),
>>> +		.flags		=
>>> cpu_to_le32(VIRTIO_IOMMU_INVAL_F_PASID), +
>>> +		.domain		= cpu_to_le32(vdomain->id),
>>> +		.pasid		= cpu_to_le32(pasid),
>>> +	};
>>> +
>>> +	if (leaf)
>>> +		req.flags	|=
>>> cpu_to_le32(VIRTIO_IOMMU_INVAL_F_LEAF); +
>>> +	if (viommu_send_req_sync(vdomain->viommu, &req, sizeof(req)))
>>> +		pr_debug("could not send invalidate request\n");
>>> +}
>>> +
>>>   /* IOMMU API */
>>>
>>>   static struct iommu_domain *viommu_domain_alloc(unsigned type)
>>
>>
>> Thanks,
>>
>> Jacob
