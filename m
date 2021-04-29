Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B910936ED8F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Apr 2021 17:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240543AbhD2Pom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Apr 2021 11:44:42 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:46662 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233451AbhD2Poj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Apr 2021 11:44:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1619711033; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=miJKmOSU4p1R325x/Qno5P55VN5HUpRy8xvKg8lc3yg=;
 b=hsuX9NQoxNChPfo9HiZtT0P/7icmFxukOoESb9V8S47Usx0LFc0a5LJ4fcm5cjwvnVP11rF9
 1T9J8fRRH51IdDhNb75dWP4EBPzUPhTTC1bLH9GimkoqLsNQviFYQb1yaRD8a+mYyVO5XGIr
 Jtag8hPcL/zHg3SRiWREH/LLVlc=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 608ad4282cc44d3aea0da04d (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 29 Apr 2021 15:43:36
 GMT
Sender: gubbaven=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1650BC433D3; Thu, 29 Apr 2021 15:43:36 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.9 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: gubbaven)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 9C3E4C433F1;
        Thu, 29 Apr 2021 15:43:33 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Thu, 29 Apr 2021 21:13:33 +0530
From:   gubbaven@codeaurora.org
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-bluetooth@vger.kernel.org, hemantg@codeaurora.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        rjliao@codeaurora.org, hbandi@codeaurora.org,
        abhishekpandit@chromium.org
Subject: Re: [PATCH v2 1/3] Bluetooth: hci_qca: Add support for QTI Bluetooth
 chip wcn6750
In-Reply-To: <YH8/Ru4pP2L6RBn4@google.com>
References: <1618936010-16579-1-git-send-email-gubbaven@codeaurora.org>
 <1618936010-16579-2-git-send-email-gubbaven@codeaurora.org>
 <YH8/Ru4pP2L6RBn4@google.com>
Message-ID: <8a5dc63a2fe460a13da00dcde0ac4236@codeaurora.org>
X-Sender: gubbaven@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Matthias,

On 2021-04-21 02:23, Matthias Kaehlcke wrote:
> On Tue, Apr 20, 2021 at 09:56:48PM +0530, Venkata Lakshmi Narayana 
> Gubba wrote:
>> Added regulators,GPIOs and changes required to power on/off wcn6750.
>> Added support for firmware download for wcn6750.
>> 
>> Changes done in detail:
>> 1. Added regulators and corresponding current values.
>> 2. Added sw_ctrl GPIO pin which is output from BT SoC and indicates
>>    status of clock supply to BT SoC.
>> 3. Added inline function to check if the SoC type is wcn399x or 
>> wcn6750.
>> 4. Modified the function qca_wcn3990_init() to support wcn6750 and
>>    renamed it to qca_regulator_init().
>> 5. Added BT_ON and BT_OFF macros.
>> 6. Added support to download mbn type firmware image as wcn6750 
>> supports
>>    mbn type image.
>> 7. If mbn type image is not present then we will check for tlv type 
>> image.
>> 8. Moved extracting rom version info to common place as this code is
>>    common in all if else ladder in qca_uart_setup.
>> 
>> Signed-off-by: Venkata Lakshmi Narayana Gubba 
>> <gubbaven@codeaurora.org>
>> ---
>>  drivers/bluetooth/btqca.c   |  88 
>> ++++++++++++++++++++++++++----------
>>  drivers/bluetooth/btqca.h   |  15 ++++++-
>>  drivers/bluetooth/hci_qca.c | 106 
>> ++++++++++++++++++++++++++++++++++----------
>>  3 files changed, 161 insertions(+), 48 deletions(-)
>> 
>> diff --git a/drivers/bluetooth/btqca.c b/drivers/bluetooth/btqca.c
>> index 25114f0..eec391a 100644
>> --- a/drivers/bluetooth/btqca.c
>> +++ b/drivers/bluetooth/btqca.c
>> @@ -182,7 +182,8 @@ int qca_send_pre_shutdown_cmd(struct hci_dev 
>> *hdev)
>>  }
>>  EXPORT_SYMBOL_GPL(qca_send_pre_shutdown_cmd);
>> 
>> -static void qca_tlv_check_data(struct qca_fw_config *config,
>> +static void qca_tlv_check_data(struct hci_dev *hdev,
>> +			       struct qca_fw_config *config,
>>  		const struct firmware *fw, enum qca_btsoc_type soc_type)
>>  {
>>  	const u8 *data;
>> @@ -194,19 +195,21 @@ static void qca_tlv_check_data(struct 
>> qca_fw_config *config,
>>  	struct tlv_type_nvm *tlv_nvm;
>>  	uint8_t nvm_baud_rate = config->user_baud_rate;
>> 
>> -	tlv = (struct tlv_type_hdr *)fw->data;
>> -
>> -	type_len = le32_to_cpu(tlv->type_len);
>> -	length = (type_len >> 8) & 0x00ffffff;
>> -
>> -	BT_DBG("TLV Type\t\t : 0x%x", type_len & 0x000000ff);
>> -	BT_DBG("Length\t\t : %d bytes", length);
>> -
>>  	config->dnld_mode = QCA_SKIP_EVT_NONE;
>>  	config->dnld_type = QCA_SKIP_EVT_NONE;
>> 
>>  	switch (config->type) {
>> +	case ELF_TYPE_PATCH:
>> +		config->dnld_mode = QCA_SKIP_EVT_VSE_CC;
>> +		config->dnld_type = QCA_SKIP_EVT_VSE_CC;
>> +
>> +		bt_dev_dbg(hdev, "File Class        : 0x%x", fw->data[4]);
>> +		bt_dev_dbg(hdev, "Data Encoding     : 0x%x", fw->data[5]);
>> +		bt_dev_dbg(hdev, "File version      : 0x%x", fw->data[6]);
>> +		break;
>>  	case TLV_TYPE_PATCH:
>> +		tlv = (struct tlv_type_hdr *)fw->data;
>> +		type_len = le32_to_cpu(tlv->type_len);
>>  		tlv_patch = (struct tlv_type_patch *)tlv->data;
>> 
>>  		/* For Rome version 1.1 to 3.1, all segment commands
>> @@ -218,6 +221,7 @@ static void qca_tlv_check_data(struct 
>> qca_fw_config *config,
>>  		config->dnld_mode = tlv_patch->download_mode;
>>  		config->dnld_type = config->dnld_mode;
>> 
>> +		BT_DBG("TLV Type\t\t : 0x%x", type_len & 0x000000ff);
>>  		BT_DBG("Total Length           : %d bytes",
>>  		       le32_to_cpu(tlv_patch->total_size));
>>  		BT_DBG("Patch Data Length      : %d bytes",
>> @@ -243,6 +247,14 @@ static void qca_tlv_check_data(struct 
>> qca_fw_config *config,
>>  		break;
>> 
>>  	case TLV_TYPE_NVM:
>> +		tlv = (struct tlv_type_hdr *)fw->data;
>> +
>> +		type_len = le32_to_cpu(tlv->type_len);
>> +		length = (type_len >> 8) & 0x00ffffff;
>> +
>> +		BT_DBG("TLV Type\t\t : 0x%x", type_len & 0x000000ff);
>> +		BT_DBG("Length\t\t : %d bytes", length);
>> +
> 
> To keep the wcn6750 shorther you could consider to have a separate 
> patch
> for the ELF type and the additional logging.
> 
[Venkata]:
Sure, I will send as a seperate patch in next patchset.
>>  		idx = 0;
>>  		data = tlv->data;
>>  		while (idx < length) {
>> @@ -387,7 +399,8 @@ static int qca_inject_cmd_complete_event(struct 
>> hci_dev *hdev)
>> 
>>  static int qca_download_firmware(struct hci_dev *hdev,
>>  				 struct qca_fw_config *config,
>> -				 enum qca_btsoc_type soc_type)
>> +				 enum qca_btsoc_type soc_type,
>> +				 u8 rom_ver)
>>  {
>>  	const struct firmware *fw;
>>  	const u8 *segment;
>> @@ -397,12 +410,29 @@ static int qca_download_firmware(struct hci_dev 
>> *hdev,
>> 
>>  	ret = request_firmware(&fw, config->fwname, &hdev->dev);
>>  	if (ret) {
>> -		bt_dev_err(hdev, "QCA Failed to request file: %s (%d)",
>> -			   config->fwname, ret);
>> -		return ret;
>> +		/* For WCN6750, if mbn file is not present then check for
>> +		 * tlv file.
>> +		 */
>> +		if (soc_type == QCA_WCN6750 && config->type == ELF_TYPE_PATCH) {
>> +			bt_dev_dbg(hdev, "QCA Failed to request file: %s (%d)",
>> +				   config->fwname, ret);
>> +			config->type = TLV_TYPE_PATCH;
>> +			snprintf(config->fwname, sizeof(config->fwname),
>> +				 "qca/msbtfw%02x.tlv", rom_ver);
>> +			ret = request_firmware(&fw, config->fwname, &hdev->dev);
>> +			if (ret) {
>> +				bt_dev_err(hdev, "QCA Failed to request file: %s (%d)",
>> +					   config->fwname, ret);
>> +				return ret;
>> +			}
>> +		} else {
>> +			bt_dev_err(hdev, "QCA Failed to request file: %s (%d)",
>> +				   config->fwname, ret);
>> +			return ret;
>> +		}
>>  	}
>> 
>> -	qca_tlv_check_data(config, fw, soc_type);
>> +	qca_tlv_check_data(hdev, config, fw, soc_type);
>> 
>>  	segment = fw->data;
>>  	remain = fw->size;
>> @@ -502,27 +532,33 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t 
>> baudrate,
>> 
>>  	config.user_baud_rate = baudrate;
>> 
>> +	/* Firmware files to download are based on ROM version.
>> +	 * ROM version is derived from last two bytes of soc_ver.
>> +	 */
>> +	rom_ver = ((soc_ver & 0x00000f00) >> 0x04) |
>> +		    (soc_ver & 0x0000000f);
>> +
> 
> This refactoring could also be done in a separate patch.
> 
[Venkata]:
Sure.I will send as a seperate patch in next patchset.
>>  	/* Download rampatch file */
>>  	config.type = TLV_TYPE_PATCH;
>>  	if (qca_is_wcn399x(soc_type)) {
>> -		/* Firmware files to download are based on ROM version.
>> -		 * ROM version is derived from last two bytes of soc_ver.
>> -		 */
>> -		rom_ver = ((soc_ver & 0x00000f00) >> 0x04) |
>> -			    (soc_ver & 0x0000000f);
>>  		snprintf(config.fwname, sizeof(config.fwname),
>>  			 "qca/crbtfw%02x.tlv", rom_ver);
>>  	} else if (soc_type == QCA_QCA6390) {
>> -		rom_ver = ((soc_ver & 0x00000f00) >> 0x04) |
>> -			    (soc_ver & 0x0000000f);
>>  		snprintf(config.fwname, sizeof(config.fwname),
>>  			 "qca/htbtfw%02x.tlv", rom_ver);
>> +	} else if (soc_type == QCA_WCN6750) {
>> +		/* Choose mbn file by default.If mbn file is not found
>> +		 * then choose tlv file
>> +		 */
>> +		config.type = ELF_TYPE_PATCH;
>> +		snprintf(config.fwname, sizeof(config.fwname),
>> +			 "qca/msbtfw%02x.mbn", rom_ver);
>>  	} else {
>>  		snprintf(config.fwname, sizeof(config.fwname),
>>  			 "qca/rampatch_%08x.bin", soc_ver);
>>  	}
>> 
>> -	err = qca_download_firmware(hdev, &config, soc_type);
>> +	err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
>>  	if (err < 0) {
>>  		bt_dev_err(hdev, "QCA Failed to download patch (%d)", err);
>>  		return err;
>> @@ -548,11 +584,14 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t 
>> baudrate,
>>  	else if (soc_type == QCA_QCA6390)
>>  		snprintf(config.fwname, sizeof(config.fwname),
>>  			 "qca/htnv%02x.bin", rom_ver);
>> +	else if (soc_type == QCA_WCN6750)
>> +		snprintf(config.fwname, sizeof(config.fwname),
>> +			 "qca/msnv%02x.bin", rom_ver);
>>  	else
>>  		snprintf(config.fwname, sizeof(config.fwname),
>>  			 "qca/nvm_%08x.bin", soc_ver);
>> 
>> -	err = qca_download_firmware(hdev, &config, soc_type);
>> +	err = qca_download_firmware(hdev, &config, soc_type, rom_ver);
>>  	if (err < 0) {
>>  		bt_dev_err(hdev, "QCA Failed to download NVM (%d)", err);
>>  		return err;
>> @@ -564,13 +603,14 @@ int qca_uart_setup(struct hci_dev *hdev, uint8_t 
>> baudrate,
>>  			return err;
>>  	}
>> 
>> -	/* WCN399x supports the Microsoft vendor extension with 0xFD70 as 
>> the
>> +	/* WCN399x and WCN6750 supports the Microsoft vendor extension with 
>> 0xFD70 as the
>>  	 * VsMsftOpCode.
>>  	 */
>>  	switch (soc_type) {
>>  	case QCA_WCN3990:
>>  	case QCA_WCN3991:
>>  	case QCA_WCN3998:
>> +	case QCA_WCN6750:
>>  		hci_set_msft_opcode(hdev, 0xFD70);
>>  		break;
>>  	default:
>> diff --git a/drivers/bluetooth/btqca.h b/drivers/bluetooth/btqca.h
>> index b19add7..3057bf8 100644
>> --- a/drivers/bluetooth/btqca.h
>> +++ b/drivers/bluetooth/btqca.h
>> @@ -80,7 +80,8 @@ enum qca_tlv_dnld_mode {
>> 
>>  enum qca_tlv_type {
>>  	TLV_TYPE_PATCH = 1,
>> -	TLV_TYPE_NVM
>> +	TLV_TYPE_NVM,
>> +	ELF_TYPE_PATCH
>>  };
>> 
>>  struct qca_fw_config {
>> @@ -143,6 +144,7 @@ enum qca_btsoc_type {
>>  	QCA_WCN3998,
>>  	QCA_WCN3991,
>>  	QCA_QCA6390,
>> +	QCA_WCN6750
>>  };
>> 
>>  #if IS_ENABLED(CONFIG_BT_QCA)
>> @@ -160,6 +162,12 @@ static inline bool qca_is_wcn399x(enum 
>> qca_btsoc_type soc_type)
>>  	return soc_type == QCA_WCN3990 || soc_type == QCA_WCN3991 ||
>>  	       soc_type == QCA_WCN3998;
>>  }
>> +static inline bool qca_is_wcn399x_wcn6750(enum qca_btsoc_type 
>> soc_type)
>> +{
>> +	return soc_type == QCA_WCN3990 || soc_type == QCA_WCN3991 ||
>> +	       soc_type == QCA_WCN3998 || soc_type == QCA_WCN6750;
>> +}
>> +
> 
> I anticipate that this would eventually need to be extended to
> 'qca_is_wcn399x_wcn6750_wcn1234', 
> 'qca_is_wcn399x_wcn6750_wcn1234_wcn9876',
> which isn't really practical. It might be better to just have 
> 'qca_is_wcn399x()'
> and 'qca_is_wcn6750()' (or qca_is_wcn675x() if applicable)
> 
> IMO
> 
>   if (qca_is_wcn399x(type) || qca_is_wcn6750(type))
> 
> isn't really worse than
> 
>   if (qca_is_wcn399x_wcn6750(type))
> 
> 
> personally I find the formwer even easier to read.
> 
[Venkata]:
Sure.I will update in next patchset.
>>  #else
>> 
>>  static inline int qca_set_bdaddr_rome(struct hci_dev *hdev, const 
>> bdaddr_t *bdaddr)
>> @@ -192,6 +200,11 @@ static inline bool qca_is_wcn399x(enum 
>> qca_btsoc_type soc_type)
>>  	return false;
>>  }
>> 
>> +static inline bool qca_is_wcn399x_wcn6750(enum qca_btsoc_type 
>> soc_type)
>> +{
>> +	return false;
>> +}
>> +
>>  static inline int qca_send_pre_shutdown_cmd(struct hci_dev *hdev)
>>  {
>>  	return -EOPNOTSUPP;
>> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
>> index 0a00569..0d25ba9 100644
>> --- a/drivers/bluetooth/hci_qca.c
>> +++ b/drivers/bluetooth/hci_qca.c
>> @@ -70,6 +70,10 @@
>>  #define QCA_CRASHBYTE_PACKET_LEN	1096
>>  #define QCA_MEMDUMP_BYTE		0xFB
>> 
>> +/* BT_EN GPIO enable/disable */
>> +#define BT_ON		1
>> +#define BT_OFF		0
> 
> These aren't really needed, passing 0 and 1 to gpio_set_value() is 
> clear enough.
> 
[Venkata]:
I will update in next patch set.
>> +
>>  enum qca_flags {
>>  	QCA_IBS_DISABLED,
>>  	QCA_DROP_VENDOR_EVENT,
>> @@ -218,6 +222,7 @@ struct qca_power {
>>  struct qca_serdev {
>>  	struct hci_uart	 serdev_hu;
>>  	struct gpio_desc *bt_en;
>> +	struct gpio_desc *sw_ctrl;
>>  	struct clk	 *susclk;
>>  	enum qca_btsoc_type btsoc_type;
>>  	struct qca_power *bt_power;
>> @@ -604,7 +609,7 @@ static int qca_open(struct hci_uart *hu)
>>  	if (hu->serdev) {
>>  		qcadev = serdev_device_get_drvdata(hu->serdev);
>> 
>> -		if (qca_is_wcn399x(qcadev->btsoc_type))
>> +		if (qca_is_wcn399x_wcn6750(qcadev->btsoc_type))
>>  			hu->init_speed = qcadev->init_speed;
>> 
>>  		if (qcadev->oper_speed)
>> @@ -1308,7 +1313,7 @@ static int qca_set_baudrate(struct hci_dev 
>> *hdev, uint8_t baudrate)
>>  		      msecs_to_jiffies(CMD_TRANS_TIMEOUT_MS));
>> 
>>  	/* Give the controller time to process the request */
>> -	if (qca_is_wcn399x(qca_soc_type(hu)))
>> +	if (qca_is_wcn399x_wcn6750(qca_soc_type(hu)))
>>  		usleep_range(1000, 10000);
>>  	else
>>  		msleep(300);
>> @@ -1384,7 +1389,7 @@ static unsigned int qca_get_speed(struct 
>> hci_uart *hu,
>> 
>>  static int qca_check_speeds(struct hci_uart *hu)
>>  {
>> -	if (qca_is_wcn399x(qca_soc_type(hu))) {
>> +	if (qca_is_wcn399x_wcn6750(qca_soc_type(hu))) {
>>  		if (!qca_get_speed(hu, QCA_INIT_SPEED) &&
>>  		    !qca_get_speed(hu, QCA_OPER_SPEED))
>>  			return -EINVAL;
>> @@ -1417,7 +1422,7 @@ static int qca_set_speed(struct hci_uart *hu, 
>> enum qca_speed_type speed_type)
>>  		/* Disable flow control for wcn3990 to deassert RTS while
>>  		 * changing the baudrate of chip and host.
>>  		 */
>> -		if (qca_is_wcn399x(soc_type))
>> +		if (qca_is_wcn399x_wcn6750(soc_type))
>>  			hci_uart_set_flow_control(hu, true);
>> 
>>  		if (soc_type == QCA_WCN3990) {
>> @@ -1434,7 +1439,7 @@ static int qca_set_speed(struct hci_uart *hu, 
>> enum qca_speed_type speed_type)
>>  		host_set_baudrate(hu, speed);
>> 
>>  error:
>> -		if (qca_is_wcn399x(soc_type))
>> +		if (qca_is_wcn399x_wcn6750(soc_type))
>>  			hci_uart_set_flow_control(hu, false);
>> 
>>  		if (soc_type == QCA_WCN3990) {
>> @@ -1585,10 +1590,12 @@ static bool qca_prevent_wake(struct hci_dev 
>> *hdev)
>>  	return !wakeup;
>>  }
>> 
>> -static int qca_wcn3990_init(struct hci_uart *hu)
>> +static int qca_regulator_init(struct hci_uart *hu)
>>  {
>> +	enum qca_btsoc_type soc_type = qca_soc_type(hu);
>>  	struct qca_serdev *qcadev;
>>  	int ret;
>> +	bool sw_ctrl_state;
>> 
>>  	/* Check for vregs status, may be hci down has turned
>>  	 * off the voltage regulator.
>> @@ -1607,16 +1614,31 @@ static int qca_wcn3990_init(struct hci_uart 
>> *hu)
>>  		}
>>  	}
>> 
>> -	/* Forcefully enable wcn3990 to enter in to boot mode. */
>> -	host_set_baudrate(hu, 2400);
>> -	ret = qca_send_power_pulse(hu, false);
>> -	if (ret)
>> -		return ret;
>> +	if (qca_is_wcn399x(soc_type)) {
>> +		/* Forcefully enable wcn3990 to enter in to boot mode. */
> 
> nit: s/wcn3990/wcn399x/ since you are already touching the code
> 
[Venkata]:
I will update in next patchset.
>> +		host_set_baudrate(hu, 2400);
>> +		ret = qca_send_power_pulse(hu, false);
>> +		if (ret)
>> +			return ret;
>> +	}
>> +
>> +	/* For wcn6750 need to enable gpio bt_en */
> 
> Does this really only apply to the wcn6750()?
> 
> From the code it's evident that the enable pin is togged, I suggest
> to drop the comment.
> 
[Venkata] :
Yes, Below code only apply to WCN6750.
>> +	if (qcadev->bt_en) {
>> +		gpiod_set_value_cansleep(qcadev->bt_en, BT_OFF);
>> +		msleep(50);
>> +		gpiod_set_value_cansleep(qcadev->bt_en, BT_ON);
>> +		msleep(50);
>> +		sw_ctrl_state = gpiod_get_value_cansleep(qcadev->sw_ctrl);
>> +		bt_dev_dbg(hu->hdev, "SW_CTRL is %d", sw_ctrl_state);
> 
> Need to check if 'sw_ctrl' is a valid GPIO?
> 
> What exactly is the role of 'SW_CTRL'?
> 
[Venkata]:
I will add check if sw_ctrl is a valid GPIO.
sw_ctrl is output from BT SoC to Host.It indicates status of clock
supply to SoC.
>> +	}
>> 
>>  	qca_set_speed(hu, QCA_INIT_SPEED);
>> -	ret = qca_send_power_pulse(hu, true);
>> -	if (ret)
>> -		return ret;
>> +
>> +	if (qca_is_wcn399x(soc_type)) {
>> +		ret = qca_send_power_pulse(hu, true);
>> +		if (ret)
>> +			return ret;
>> +	}
>> 
>>  	/* Now the device is in ready state to communicate with host.
>>  	 * To sync host with device we need to reopen port.
>> @@ -1649,12 +1671,12 @@ static int qca_power_on(struct hci_dev *hdev)
>>  	if (!hu->serdev)
>>  		return 0;
>> 
>> -	if (qca_is_wcn399x(soc_type)) {
>> -		ret = qca_wcn3990_init(hu);
>> +	if (qca_is_wcn399x_wcn6750(soc_type)) {
>> +		ret = qca_regulator_init(hu);
>>  	} else {
>>  		qcadev = serdev_device_get_drvdata(hu->serdev);
>>  		if (qcadev->bt_en) {
>> -			gpiod_set_value_cansleep(qcadev->bt_en, 1);
>> +			gpiod_set_value_cansleep(qcadev->bt_en, BT_ON);
>>  			/* Controller needs time to bootup. */
>>  			msleep(150);
>>  		}
>> @@ -1689,7 +1711,8 @@ static int qca_setup(struct hci_uart *hu)
>>  	set_bit(HCI_QUIRK_SIMULTANEOUS_DISCOVERY, &hdev->quirks);
>> 
>>  	bt_dev_info(hdev, "setting up %s",
>> -		qca_is_wcn399x(soc_type) ? "wcn399x" : "ROME/QCA6390");
>> +		qca_is_wcn399x(soc_type) ? "wcn399x" :
>> +		(soc_type == QCA_WCN6750) ? "wcn6750" : "ROME/QCA6390");
>> 
>>  	qca->memdump_state = QCA_MEMDUMP_IDLE;
>> 
>> @@ -1700,7 +1723,7 @@ static int qca_setup(struct hci_uart *hu)
>> 
>>  	clear_bit(QCA_SSR_TRIGGERED, &qca->flags);
>> 
>> -	if (qca_is_wcn399x(soc_type)) {
>> +	if (qca_is_wcn399x_wcn6750(soc_type)) {
>>  		set_bit(HCI_QUIRK_USE_BDADDR_PROPERTY, &hdev->quirks);
>> 
>>  		ret = qca_read_soc_version(hdev, &ver, soc_type);
>> @@ -1720,7 +1743,7 @@ static int qca_setup(struct hci_uart *hu)
>>  		qca_baudrate = qca_get_baudrate_value(speed);
>>  	}
>> 
>> -	if (!qca_is_wcn399x(soc_type)) {
>> +	if (!qca_is_wcn399x_wcn6750(soc_type)) {
>>  		/* Get QCA version information */
>>  		ret = qca_read_soc_version(hdev, &ver, soc_type);
>>  		if (ret)
>> @@ -1828,12 +1851,30 @@ static const struct qca_device_data 
>> qca_soc_data_qca6390 = {
>>  	.num_vregs = 0,
>>  };
>> 
>> +static const struct qca_device_data qca_soc_data_wcn6750 = {
>> +	.soc_type = QCA_WCN6750,
>> +	.vregs = (struct qca_vreg []) {
>> +		{ "vddio", 5000 },
>> +		{ "vddaon", 26000 },
>> +		{ "vddbtcxmx", 126000 },
>> +		{ "vddrfacmn", 12500 },
>> +		{ "vddrfa0p8", 102000 },
>> +		{ "vddrfa1p7", 302000 },
>> +		{ "vddrfa1p2", 257000 },
>> +		{ "vddrfa2p2", 1700000 },
>> +		{ "vddasd", 200 },
>> +	},
>> +	.num_vregs = 9,
>> +	.capabilities = QCA_CAP_WIDEBAND_SPEECH | QCA_CAP_VALID_LE_STATES,
>> +};
>> +
>>  static void qca_power_shutdown(struct hci_uart *hu)
>>  {
>>  	struct qca_serdev *qcadev;
>>  	struct qca_data *qca = hu->priv;
>>  	unsigned long flags;
>>  	enum qca_btsoc_type soc_type = qca_soc_type(hu);
>> +	bool sw_ctrl_state;
>> 
>>  	qcadev = serdev_device_get_drvdata(hu->serdev);
>> 
>> @@ -1856,8 +1897,14 @@ static void qca_power_shutdown(struct hci_uart 
>> *hu)
>>  		host_set_baudrate(hu, 2400);
>>  		qca_send_power_pulse(hu, false);
>>  		qca_regulator_disable(qcadev);
>> +	} else if (soc_type == QCA_WCN6750) {
>> +		gpiod_set_value_cansleep(qcadev->bt_en, BT_OFF);
>> +		msleep(100);
>> +		qca_regulator_disable(qcadev);
>> +		sw_ctrl_state = gpiod_get_value_cansleep(qcadev->sw_ctrl);
>> +		bt_dev_dbg(hu->hdev, "SW_CTRL is %d", sw_ctrl_state);
>>  	} else if (qcadev->bt_en) {
>> -		gpiod_set_value_cansleep(qcadev->bt_en, 0);
>> +		gpiod_set_value_cansleep(qcadev->bt_en, BT_OFF);
>>  	}
>> 
>>  	set_bit(QCA_BT_OFF, &qca->flags);
>> @@ -1978,7 +2025,7 @@ static int qca_serdev_probe(struct serdev_device 
>> *serdev)
>>  	if (!qcadev->oper_speed)
>>  		BT_DBG("UART will pick default operating speed");
>> 
>> -	if (data && qca_is_wcn399x(data->soc_type)) {
>> +	if (data && qca_is_wcn399x_wcn6750(data->soc_type)) {
>>  		qcadev->btsoc_type = data->soc_type;
>>  		qcadev->bt_power = devm_kzalloc(&serdev->dev,
>>  						sizeof(struct qca_power),
>> @@ -1996,6 +2043,18 @@ static int qca_serdev_probe(struct 
>> serdev_device *serdev)
>> 
>>  		qcadev->bt_power->vregs_on = false;
>> 
>> +		qcadev->bt_en = devm_gpiod_get_optional(&serdev->dev, "enable",
>> +					       GPIOD_OUT_LOW);
>> +		if (!qcadev->bt_en && data->soc_type == QCA_WCN6750) {
>> +			dev_err(&serdev->dev, "failed to acquire BT_EN gpio\n");
>> +			power_ctrl_enabled = false;
>> +		}
>> +
>> +		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
>> +					       GPIOD_IN);
>> +		if (!qcadev->sw_ctrl && data->soc_type == QCA_WCN6750)
>> +			dev_warn(&serdev->dev, "failed to acquire SW_CTRL gpio\n");
>> +
>>  		qcadev->susclk = devm_clk_get_optional(&serdev->dev, NULL);
>>  		if (IS_ERR(qcadev->susclk)) {
>>  			dev_err(&serdev->dev, "failed to acquire clk\n");
>> @@ -2068,7 +2127,7 @@ static void qca_serdev_remove(struct 
>> serdev_device *serdev)
>>  	struct qca_serdev *qcadev = serdev_device_get_drvdata(serdev);
>>  	struct qca_power *power = qcadev->bt_power;
>> 
>> -	if (qca_is_wcn399x(qcadev->btsoc_type) && power->vregs_on)
>> +	if (qca_is_wcn399x_wcn6750(qcadev->btsoc_type) && power->vregs_on)
>>  		qca_power_shutdown(&qcadev->serdev_hu);
>>  	else if (qcadev->susclk)
>>  		clk_disable_unprepare(qcadev->susclk);
>> @@ -2244,6 +2303,7 @@ static const struct of_device_id 
>> qca_bluetooth_of_match[] = {
>>  	{ .compatible = "qcom,wcn3990-bt", .data = &qca_soc_data_wcn3990},
>>  	{ .compatible = "qcom,wcn3991-bt", .data = &qca_soc_data_wcn3991},
>>  	{ .compatible = "qcom,wcn3998-bt", .data = &qca_soc_data_wcn3998},
>> +	{ .compatible = "qcom,wcn6750-bt", .data = &qca_soc_data_wcn6750},
>>  	{ /* sentinel */ }
>>  };
>>  MODULE_DEVICE_TABLE(of, qca_bluetooth_of_match);
>> --
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
>> member
>> of Code Aurora Forum, hosted by The Linux Foundation
>> 

Regards,
Venkata.
